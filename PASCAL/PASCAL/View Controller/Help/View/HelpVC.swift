//
//  HelpVC.swift
//  PASCAL
//
//  Created by My Mac on 15/12/21.
//

import Foundation
import UIKit
import DropDown

protocol HelpView: AnyObject {
    
}


class HelpVC: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - GLOBAL VARIABLES
    @IBOutlet weak var brnHelp: UIButton!
    @IBOutlet weak var EmailView: viewProperties!
    @IBOutlet weak var btnPopup: UIButton!
    let OnDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.OnDropDown
        ]
    }()
    
    var presenter:HelpPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        self.EmailView.addGestureRecognizer(gesture)
        brnHelp.setTitle("Help".localizableString().uppercased(), for: .normal)
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        ChooseOnDropDown()
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
    @objc func clickAction(sender : UITapGestureRecognizer) {
        openMail()
    }
    @IBAction func btnEmail_Action(_ sender: Any) {
        openMail()
    }
    
    @objc func Reload()
    {
        let nextVC = HelpModule().viewController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    //MARK:- open mail box
    func openMail() {
        if let url = URL(string: "mailto:loadfit@cleral.com") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

// MARK: - EXTENSIONS
extension HelpVC:HelpView {
    
}

extension HelpVC: InfoPopupDelegate {
    func onOKButtonTouchup() {
        DeleteAllData()
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Reload), userInfo: nil, repeats: false)
    }
    
    func onDismissButtonTouchup() {
        
    }
}
