//
//  DeviceVC.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit
import SideMenu
import Rswift
import AVFoundation
import CoreData
import DropDown
import CoreBluetooth

protocol DeviceView: AnyObject {
    
}

class deviceCell: UITableViewCell {
    @IBOutlet weak var btnChannel: UIButton!
    @IBOutlet weak var txtWeights: UITextField!
    @IBOutlet weak var txtLimit: UITextField!
}

class DeviceVC: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - GLOBAL VARIABLES
    var presenter:DevicePresenter!
    var playerA: AVAudioPlayer!
    var playerB: AVAudioPlayer!
    @IBOutlet weak var btnActionType: UIButton!
    @IBOutlet weak var tblDevice: UITableView!
    @IBOutlet weak var lblWeightTotal: UILabel!
    @IBOutlet weak var lblLimitTotal: UILabel!
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblChannel: UILabel!
    @IBOutlet weak var lblWeights: UILabel!
    @IBOutlet weak var lblLimit: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblGross: UILabel!
    @IBOutlet weak var lblNet: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnPopup: UIButton!
    let OnDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.OnDropDown
        ]
    }()
    
    var channelArray = ["A","B"]
    var totalWeight = 0
    var totalLimit = 0
    var btnType: String = "gross"
    var ReciveDic = [String : String]()
    var RandomDic = [[String: String]]()
    var buffer = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.setTitle("Weights".localizableString().uppercased(), for: .normal)
        btnSave.setTitle("Save".localizableString().uppercased(), for: .normal)
        lblChannel.text = "Channel".localizableString()
        lblWeights.text = "Weights".localizableString()
        lblLimit.text = "Limits".localizableString()
        lblTotal.text = "Total".localizableString()
        lblGross.text = "Gross".localizableString()
        lblNet.text = "Net".localizableString()
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        ChooseOnDropDown()
        
#if targetEnvironment(simulator)
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
#endif
    }
    
    // TODO: For testing purpose
    var frame = ";11-11-20;06:13:37;UNIT;kg;GWA;7858;GWB;7848;NTA;4538;NTB;2432;GWT;15706;NTT;6980;CKS;48;;TIME;11-11-20;06:13:37;UNIT;kg;GWA;7858;GWB;7848;NTA;4538;NTB;2432;GWT;1547;NTT;6980;CKS;48;"
    
    // TODO: For testing purpose
    @objc func timerAction() {
        
        let GWA = Int.random(in: 5000..<7848)
        let GWB = Int.random(in: 2000..<5000)
        let GWT = GWA + GWB
        
        let NTA = Int.random(in: 1000..<5000)
        let NTB = Int.random(in: 5000..<10000)
        let NTT = NTA + NTB
        
        frame += ";TIME;11-11-20;06:13:37;UNIT;kg;GWA;\(GWA);GWB;\(GWB);NTA;\(NTA);NTB;\(NTB);GWT;\(GWT);NTT;\(NTT);CKS;48;"

        let stringArray = frame.match()
        
        for str in stringArray {
            let separatedFrame = str.components(separatedBy: ";")
            var i = 0
            var dic = [String:String]()
            
            while (i < separatedFrame.count - 1) {
                let key = separatedFrame[i]
                var value = separatedFrame[i + 1]
                if key != "" {
                    if key == "TIME" {
                        value = separatedFrame[i + 1] + " " + separatedFrame[i + 2]
                        i = i + 1
                    }
                    dic[key] = value
                    i = i + 1
                }
                i = i + 1
            }
            ReciveDic = dic
            tblDevice.reloadData()
            frame = frame.replacingOccurrences(of: str, with: "")
            tblDevice.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if manager != nil {
            manager?.delegate = self
        }
        
        if discoveredPeripheral != nil {
            discoveredPeripheral?.delegate = self
        }

        setupView()
    }
    
    func CallFire(value : [String : String])
    {
        ReciveDic = value
        tblDevice.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        pauseASound()
        pauseBSound()
    }
    
//    @objc func fire()
//    {
//        ReciveDic.removeAll()
//        let indaxArr = [0,1,2,3]
//        let randomElement = indaxArr.randomElement()!
//        ReciveDic = RandomDic[randomElement]
//        tblDevice.reloadData()
//    }

    func setupView()
    {
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.unitType) == "LBS"
        {
            if UserDefaults.getString(forKey: Constant.UserDefaultsKey.weightsType) == "net" {
                btnType = "net"
                btnActionType.setImage(R.image.on(), for: .normal)
                let LNLimitA = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LNLimitA)
                let LNLimitB = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LNLimitB)
                lblLimitTotal.text = "\(LNLimitA + LNLimitB)"
                if lblLimitTotal.text == "0"{
                    lblLimitTotal.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                    lblLimitTotal.text = "Ex 500"
                }
                else{
                    lblLimitTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            } else {
                btnType = "gross"
                btnActionType.setImage(R.image.offBlue(), for: .normal)
                let LGLimitA = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LGLimitA)
                let LGLimitB = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LGLimitB)
                lblLimitTotal.text = "\(LGLimitA + LGLimitB)"
                if lblLimitTotal.text == "0"{
                    lblLimitTotal.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                    lblLimitTotal.text = "Ex 500"
                }
                else{
                    lblLimitTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            }
        }
        else{
            if UserDefaults.getString(forKey: Constant.UserDefaultsKey.weightsType) == "net" {
                btnType = "net"
                btnActionType.setImage(R.image.on(), for: .normal)
                let NlimitA = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KNLimitA)
                let NlimitB = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KNLimitB)
                lblLimitTotal.text = "\(NlimitA + NlimitB)"
                if lblLimitTotal.text == "0"{
                    lblLimitTotal.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                    lblLimitTotal.text = "Ex 500"
                }
                else{
                    lblLimitTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            } else {
                btnType = "gross"
                btnActionType.setImage(R.image.offBlue(), for: .normal)
                let GlimitA = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KGLimitA)
                let GlimitB = UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KGLimitB)
                lblLimitTotal.text = "\(GlimitA + GlimitB)"
                if lblLimitTotal.text == "0"{
                    lblLimitTotal.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                    lblLimitTotal.text = "Ex 500"
                }
                else{
                    lblLimitTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            }
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
        //self.OnDropDown.dataSource = ["Share History".localizableString(),"Delete History".localizableString(),"Share Logs".localizableString(),]
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
    
    @IBAction func btnListType_Action(_ sender: Any) {
        
        if btnType == "gross" {
            btnType = "net"
            UserDefaults.saveString(btnType, forKey: Constant.UserDefaultsKey.weightsType)
            btnActionType.setImage(R.image.on(), for: .normal)
            tblDevice.reloadData()
        } else {
            btnType = "gross"
            UserDefaults.saveString(btnType, forKey: Constant.UserDefaultsKey.weightsType)
            btnActionType.setImage(R.image.offBlue(), for: .normal)
            tblDevice.reloadData()
        }
    }
    
    @IBAction func btnSave_Action(_ sender: Any) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Weight", in: context)
        let contact = NSManagedObject(entity: entity!, insertInto: context)
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.weightsType) == "net"
        {
            contact.setValue(ReciveDic["NTA"], forKey: "chanel_A")
            contact.setValue(ReciveDic["NTB"], forKey: "chanel_B")
            contact.setValue(ReciveDic["NTT"], forKey: "total")
            contact.setValue("Net", forKey: "app_type")
        }
        else{
            contact.setValue(ReciveDic["GWA"], forKey: "chanel_A")
            contact.setValue(ReciveDic["GWB"], forKey: "chanel_B")
            contact.setValue(ReciveDic["GWT"], forKey: "total")
            contact.setValue("Gross", forKey: "app_type")
        }
        contact.setValue(ReciveDic["UNIT"], forKey: "unit_type")
#if targetEnvironment(simulator)
        contact.setValue("K4-9721", forKey: "device_name")
#else
        contact.setValue(discoveredPeripheral?.name, forKey: "device_name")
#endif
        
        contact.setValue(UIDevice.current.identifierForVendor?.uuidString, forKey: "device_address")
        contact.setValue(getCurrentDateAndTime(), forKey: "created_date")
        contact.setValue("", forKey: "frame")
        
        do {
            try context.save()
            self.view.makeToast("Record saved successfully!".localizableString(), duration: 1.0, position: .bottom)
        } catch let error as NSError {
            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorDialog, animated: true)
        }
        
    }
    // MARK: - Sound Play/Puase
    func playASound(){
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.alarmSound) != "off"{
            let url = Bundle.main.url(forResource: "AnchhorEasy_FCM", withExtension: "wav")
            playerA = try! AVAudioPlayer(contentsOf: url!)
            playerA.play()
        }
    }
    func pauseASound(){
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.alarmSound) != "off"{
            if playerA != nil {
                playerA.stop()
                playerA = nil
            }
        }
    }
    func playBSound(){
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.alarmSound) != "off"{
            let url = Bundle.main.url(forResource: "AnchhorEasy_FCM", withExtension: "wav")
            playerB = try! AVAudioPlayer(contentsOf: url!)
            playerB.play()
        }
    }
    func pauseBSound(){
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.alarmSound) != "off"{
            if playerB != nil {
                playerB.stop()
                playerB = nil
            }
        }
    }
}

// MARK: - EXTENSIONS
extension DeviceVC:DeviceView {
    
}

extension DeviceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDevice.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! deviceCell
        cell.btnChannel.SetRadius()
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.unitType) == "LBS"
        {
            if btnType == "gross" {
                if indexPath.row == 0{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LGLimitA))"
                    cell.txtWeights.text = ReciveDic["GWA"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseASound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LGLimitA) >= Int(ReciveDic["GWA"]!)!{
                            // Pause
                            pauseASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                else{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LGLimitB))"
                    cell.txtWeights.text = ReciveDic["GWB"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseBSound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LGLimitB) >= Int(ReciveDic["GWB"]!)!{
                            // Pause
                            pauseBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                setupView()
                lblWeightTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                lblWeightTotal.text = ReciveDic["GWT"] ?? ""
            }
            else{
                if indexPath.row == 0{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LNLimitA))"
                    cell.txtWeights.text = ReciveDic["NTA"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseASound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LNLimitA) >= Int(ReciveDic["NTA"]!)!{
                            // Pause
                            pauseASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                else{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LNLimitB))"
                    cell.txtWeights.text = ReciveDic["NTB"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseBSound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.LNLimitB) >= Int(ReciveDic["NTB"]!)!{
                            // Pause
                            pauseBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                setupView()
                lblWeightTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                lblWeightTotal.text = ReciveDic["NTT"] ?? ""
            }
        }
        else{
            if btnType == "gross" {
                if indexPath.row == 0{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KGLimitA))"
                    cell.txtWeights.text = ReciveDic["GWA"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseASound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KGLimitA) >= Int(ReciveDic["GWA"]!)!{
                            // Pause
                            pauseASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                else{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KGLimitB))"
                    cell.txtWeights.text = ReciveDic["GWB"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseBSound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KGLimitB) >= Int(ReciveDic["GWB"]!)!{
                            // Pause
                            pauseBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                setupView()
                lblWeightTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                lblWeightTotal.text = ReciveDic["GWT"] ?? ""
            }
            else{
                if indexPath.row == 0{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KNLimitA))"
                    cell.txtWeights.text = ReciveDic["NTA"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseASound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KNLimitA) >= Int(ReciveDic["NTA"]!)!{
                            // Pause
                            pauseASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playASound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                else{
                    cell.txtLimit.text = "\(UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KNLimitB))"
                    cell.txtWeights.text = ReciveDic["NTB"] ?? ""
                    if cell.txtLimit.text == "0"{
                        cell.txtLimit.text = ""
                        pauseBSound()
                        cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                    }
                    else{
                        if UserDefaults.getInt(forKey: Constant.UserDefaultsKey.KNLimitB) >= Int(ReciveDic["NTB"]!)!{
                            // Pause
                            pauseBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.6823529412, blue: 0.003921568627, alpha: 1)
                        }
                        else{
                            // Play
                            playBSound()
                            cell.btnChannel.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                        }
                    }
                }
                setupView()
                lblWeightTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                lblWeightTotal.text = ReciveDic["NTT"] ?? ""
            }
        }
        cell.txtLimit.tag = indexPath.row
        cell.txtWeights.tag = indexPath.row
        cell.btnChannel.tag = indexPath.row
        cell.btnChannel.setTitle(channelArray[indexPath.row], for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 35
    }
}

extension DeviceVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var totals = 0
        var limits = 0
        for (index,_) in channelArray.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tblDevice.cellForRow(at: indexPath) as? deviceCell
            totals += cell?.txtWeights.text?.toInt() ?? 0
            limits += cell?.txtLimit.text?.toInt() ?? 0
        }
        if UserDefaults.getString(forKey: Constant.UserDefaultsKey.unitType) == "LBS"{
            if btnType == "gross" {
                if textField.tag == 0{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.LGLimitA)
                    self.view.makeToast("Channel A Limit Saved.".localizableString(), duration: 1.0, position: .bottom)
                }
                else{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.LGLimitB)
                    self.view.makeToast("Channel B Limit Saved.".localizableString(), duration: 1.0, position: .bottom)
                }
            }
            else{
                if textField.tag == 0{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.LNLimitA)
                    self.view.makeToast("Channel A Limit Saved.".localizableString(), duration: 1.0, position: .bottom)                }
                else{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.LNLimitB)
                    self.view.makeToast("Channel B Limit Saved.".localizableString(), duration: 1.0, position: .bottom)
                }
            }
        }
        else{
            if btnType == "gross" {
                if textField.tag == 0{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.KGLimitA)
                    self.view.makeToast("Channel A Limit Saved.".localizableString(), duration: 1.0, position: .bottom)                }
                else{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.KGLimitB)
                    self.view.makeToast("Channel B Limit Saved.".localizableString(), duration: 1.0, position: .bottom)
                }
            }
            else{
                if textField.tag == 0{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.KNLimitA)
                    self.view.makeToast("Channel A Limit Saved.".localizableString(), duration: 1.0, position: .bottom)                }
                else{
                    UserDefaults.saveString(textField.text, forKey: Constant.UserDefaultsKey.KNLimitB)
                    self.view.makeToast("Channel B Limit Saved.".localizableString(), duration: 1.0, position: .bottom)
                    
                }
            }
        }
        
        lblLimitTotal.text = "\(limits)"
        lblWeightTotal.text = "\(totals)"
        if lblLimitTotal.text == "0"{
            lblLimitTotal.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            lblLimitTotal.text = "Ex 500"
        }
        else{
            lblLimitTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        if lblWeightTotal.text == "0"{
            lblWeightTotal.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            lblWeightTotal.text = "Ex 500"
        }
        else{
            lblWeightTotal.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        tblDevice.reloadData()
    }
}

extension DeviceVC: CBPeripheralDelegate, CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState( _ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
        @unknown default:
            fatalError()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        //logView.isHidden = false
        
        print("connected to \(peripheral)")
        
        
        if peripheral == discoveredPeripheral {
            peripheral.discoverServices([TransferService.serviceUUID])
        }
        
        print("centralManager:didConnect() identifier --> \(peripheral.identifier.description)")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        guard peripheral.services != nil else { return }
       
        if let services = peripheral.services {
            for service in services {
                if service.uuid == TransferService.serviceUUID {
                    print("Service found --> \(service.uuid)")
                    peripheral.discoverCharacteristics([TransferService.readCharacteristicUUID, TransferService.writeCharacteristicUUID], for: service)
                    return
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("Enabling notify ", characteristic.uuid)
        
        if error != nil {
            print("Enable notify error --> \(String(describing: error?.localizedDescription))")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if let error = error {
            print("Error discovering characteristics: %s", error.localizedDescription)
            return
        }
        
        guard let characteristicData = characteristic.value else { return }
        
        buffer.append(characteristicData)
        
        guard let stringFromData = String(data: buffer, encoding: .utf8) else { return }
        
        print("Received \(characteristicData.count) bytes: \(stringFromData)")
        
        let frameArray = stringFromData.match()
        
        for frame in frameArray {
            let separatedFrame = frame.components(separatedBy: ";")
            var i = 0
            var dic = [String:String]()
            
            while (i < separatedFrame.count - 1) {
                let key = separatedFrame[i]
                var value = separatedFrame[i + 1]
                if key != "" {
                    if key == "TIME" {
                        value = separatedFrame[i + 1] + " " + separatedFrame[i + 2]
                        i = i + 1
                    }
                    dic[key] = value
                    i = i + 1
                }
                i = i + 1
            }
            
            print(dic)
            ReciveDic = dic
            tblDevice.reloadData()
            
            let remainingString = stringFromData.replacingOccurrences(of: frame, with: "")
            buffer = Data(remainingString.utf8)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        // Again, we loop through the array, just in case and check if it's the right one
        guard let serviceCharacteristics = service.characteristics else { return }
        
        for characteristic in serviceCharacteristics {
            
            if characteristic.properties.contains(.read) {
                print("\(characteristic.uuid): properties contains .read")
            }
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): properties contains .notify")
            }
            if characteristic.properties.contains(.write) {
                print("\(characteristic.uuid): properties contains .write")
            }
            if characteristic.properties.contains(.writeWithoutResponse) {
                print("\(characteristic.uuid): properties contains .writeWithoutResponse")
            }
            
            print("Found characteristic --> \(characteristic)")
            if characteristic.uuid == TransferService.readCharacteristicUUID {
                print("Read characteristic found")
                peripheral.setNotifyValue(true, for: characteristic)
            } else if characteristic.uuid == TransferService.writeCharacteristicUUID {
                print("Write characteristic found")
                //self.writeCharacteristic = characteristic
                //peripheral.setNotifyValue(true, for: characteristic)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //DispatchQueue.main.async {
            print("*BOX/SSTATUS/GET/DATA# --> Command Sent")
        }
        
    }
}

extension DeviceVC: InfoPopupDelegate {
    func onOKButtonTouchup() {
        DeleteAllData()
        //_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Reload), userInfo: nil, repeats: false)
    }
    
    func onDismissButtonTouchup() {
        
    }
}
