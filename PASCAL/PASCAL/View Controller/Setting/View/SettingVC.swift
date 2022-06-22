//
//  SettingVC.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit
import RSSelectionMenu
import DropDown

protocol SettingView: AnyObject {
}

class SettingVC: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - GLOBAL VARIABLES
    var presenter:SettingPresenter!
    var sound = "off"
    var unitType = ["KG".localizableString(), "LBS".localizableString()]
    var language = ["English", "Français"]
    var selectedUnitType: [String] = []
    var selectedLanguage: [String] = []
    
    @IBOutlet weak var btnUnitType: UIButton!
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var btnAlarmSound: UIButton!
    
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var lblUnitType: UILabel!
    @IBOutlet weak var lblAlarmSound: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var btnPopup: UIButton!
    let OnDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.OnDropDown
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        btnSetting.setTitle("Settings".localizableString().uppercased(), for: .normal)
        lblUnitType.text = "Unit Type".localizableString()
        lblAlarmSound.text = "Alarm Sound".localizableString()
        lblLanguage.text = "Language".localizableString()
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        ChooseOnDropDown()
    }
    func setupView() {
        var unitType = UserDefaults.getString(forKey: Constant.UserDefaultsKey.unitType) ?? ""
        if unitType == "LBS".localizableString(){
            unitType = "LBS".localizableString()
            selectedUnitType = ["LBS"]
        }
        else{
            unitType = "KG".localizableString()
            selectedUnitType = ["KG"]
        }
        self.btnUnitType.setTitle(unitType, for: .normal)
        
        var languageType = UserDefaults.getString(forKey: Constant.UserDefaultsKey.language) ?? ""
        if languageType == "Français"{
            selectedLanguage = ["Français"]
        }
        else{
            languageType = "English"
            selectedLanguage = ["English"]
        }
        self.btnLanguage.setTitle(languageType, for: .normal)
        
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.alarmSound) == "off" {
            sound = "off"
            btnAlarmSound.setImage(#imageLiteral(resourceName: "off blue"), for: .normal)
        } else {
            sound = "on"
            btnAlarmSound.setImage(#imageLiteral(resourceName: "on"), for: .normal)
        }
    }
    
    // MARK: - IBAction
    @IBAction func SideMenu(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueSide", sender: self)
    }
    func ChooseOnDropDown(){
        self.OnDropDown.anchorView = btnPopup
        self.OnDropDown.bottomOffset = CGPoint(x: -175, y: btnPopup.bounds.height)
        self.OnDropDown.textFont = UIFont(name: "OSWALD-REGULAR", size: 18)!
        //self.OnDropDown.dataSource = ["Share History".localizableString(),"Delete History".localizableString(),"Share Logs".localizableString()]
        self.OnDropDown.dataSource = ["Share History".localizableString(),"Delete History".localizableString()]
        self.OnDropDown.selectionAction = { [weak self] (index, item) in
            print(index)
            if index == 0{
                Main.init().DropDownOption(view: self!)
            }
            else if index == 1{
                self!.showInfoPopup(titleString: "DELETE", messageString: "Are you sure you want to delete history?")
            }
            else{
                self!.toLogListVC()
            }
        }
    }
    @IBAction func Menu(_ sender: UIButton) {
        OnDropDown.show()
    }
    @IBAction func btnAlarmSound_Acion(_ sender: UIButton) {
        if sound == "off" {
            sound = "on"
            UserDefaults.saveString(sound, forKey: Constant.UserDefaultsKey.alarmSound)
            btnAlarmSound.setImage(#imageLiteral(resourceName: "on"), for: .normal)
            self.view.makeToast("Weight alarm enabled!".localizableString(), duration: 1.0, position: .bottom)
        } else {
            sound = "off"
            UserDefaults.saveString(sound, forKey: Constant.UserDefaultsKey.alarmSound)
            btnAlarmSound.setImage(#imageLiteral(resourceName: "off blue"), for: .normal)
            self.view.makeToast("Weight alarm disabled!".localizableString(), duration: 1.0, position: .bottom)
        }
    }
    @IBAction func btnUnitType_Action(_ sender: Any) {
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: unitType) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        menu.tableView?.bounces = false
        // provide selected items
        menu.setSelectedItems(items: selectedUnitType) { (name, index, selected, selectedItems) in
            UserDefaults.saveString(name, forKey: Constant.UserDefaultsKey.unitType)
            self.btnUnitType.setTitle(name, for: .normal)
            self.selectedUnitType = selectedItems
            self.view.makeToast("Unit type saved!".localizableString(), duration: 1.0, position: .bottom)
        }
        // show - Present
        menu.show(style: .popover(sourceView: sender as! UIView, size: CGSize(width: btnUnitType.frame.size.width, height: 75), arrowDirection: .up, hideNavBar: false), from: self)
    }
    @IBAction func btnLanguage_Action(_ sender: Any) {
        let menu = RSSelectionMenu(selectionStyle: .single, dataSource: language) { (cell, name, indexPath) in
            cell.textLabel?.text = name
        }
        menu.tableView?.bounces = false
        // provide selected items
        menu.setSelectedItems(items: selectedLanguage) { (name, index, selected, selectedItems) in
            self.selectedLanguage = selectedItems
            UserDefaults.saveString(name, forKey: Constant.UserDefaultsKey.language)
            self.btnLanguage.setTitle(name, for: .normal)
            self.selectedLanguage = selectedItems
            self.view.makeToast("Language saved!".localizableString(), duration: 1.0, position: .bottom)
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.GoToRoot), userInfo: nil, repeats: false)
        }
        // show - Present
        menu.show(style: .popover(sourceView: sender as! UIView, size: CGSize(width: btnLanguage.frame.size.width, height: 75), arrowDirection: .up, hideNavBar: false), from: self)
    }
    @objc func GoToRoot()
    {
        let nextVC = DeviceListModule().viewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func Reload()
    {
        let nextVC = SettingModule().viewController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
}

// MARK: - EXTENSIONS
extension SettingVC:SettingView {
    
}

extension SettingVC: InfoPopupDelegate {
    func onOKButtonTouchup() {
        DeleteAllData()
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Reload), userInfo: nil, repeats: false)
    }
    
    func onDismissButtonTouchup() {
        
    }
}
