//
//  HistoryVC.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit
import CoreData
import DropDown
protocol HistoryView: AnyObject {
    
}

class historyCell: UITableViewCell {
    
    @IBOutlet weak var ChannelA_lbl: UILabel!
    @IBOutlet weak var ChannelB_lbl: UILabel!
    @IBOutlet weak var ChannelName_lbl: UILabel!
    @IBOutlet weak var Date_lbl: UILabel!
    @IBOutlet weak var Total_lbl: UILabel!
    @IBOutlet weak var DeviseName_lbl: UILabel!
}

class HistoryVC: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - GLOBAL VARIABLES
    var presenter:HistoryPresenter!
    var RecordArr: [NSManagedObject] = []
    var logHistoryFile = String()
    var isShareLog = false
    
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var lblNoRecord: UILabel!
    
    @IBOutlet weak var WarningView: viewProperties!
    @IBOutlet weak var tblHistory: UITableView!
    
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
        btnHistory.setTitle("History".localizableString().uppercased(), for: .normal)
        lblNoRecord.text = "Ops! No weight data found!".localizableString()
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        ChooseOnDropDown()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    func setupView(){
        RecordArr.removeAll()
        let db = getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Weight")
        
        do {
            RecordArr = try db.fetch(fetchRequest)
            print(RecordArr.count)
            if RecordArr.count == 0{
                RecordArr.removeAll()
                tblHistory.isHidden = true
                WarningView.isHidden = false
            }else{
                RecordArr = RecordArr.reversed()
                tblHistory.reloadData()
                tblHistory.isHidden = false
                WarningView.isHidden = true
            }
        } catch let error as NSError {
            let errorDialog = UIAlertController(title: "Error!", message: "Failed to save! \(error): \(error.userInfo)", preferredStyle: .alert)
            errorDialog.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(errorDialog, animated: true)
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
                self!.isShareLog = true
                self!.createHistoryFile()
            }
            else if index == 1{
                self!.showInfoPopup(titleString: "DELETE", messageString: "Are you sure you want to delete history?")
            }
            else{
                self!.isShareLog = false
                self!.createHistoryFile()
            }
        }
    }
    @IBAction func Menu(_ sender: UIButton) {
        OnDropDown.show()
    }
    
    @objc func Reload()
    {
        let nextVC = HistoryModule().viewController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    func createHistoryFile() {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let strTemp = dateformatter.string(from: date)
        logHistoryFile = "History " + strTemp.replacingOccurrences(of: ":", with: "_") + ".txt"
        let file = logHistoryFile
        let text = "\n"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print(dir)
            let fileURL = dir.appendingPathComponent(file)
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                self.writeHistory()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func writeHistory() {
        for i in 0 ..< RecordArr.count {
            let createdDate = RecordArr[i].value(forKeyPath: "created_date") as! String
            let dateARray = createdDate.components(separatedBy: " ")
            "\nDate : \(dateARray[0])".ToFile(fileName: logHistoryFile)
            "\nTime : \(dateARray[1])".ToFile(fileName: logHistoryFile)
            "\nDevice Name : \(RecordArr[i].value(forKeyPath: "device_name")! as! String)".ToFile(fileName: logHistoryFile)
            "\nUnit : \(RecordArr[i].value(forKeyPath: "unit_type")! as! String)".ToFile(fileName: logHistoryFile)
            "\nA : \(RecordArr[i].value(forKeyPath: "chanel_A") as! String)".ToFile(fileName: logHistoryFile)
            "\nB : \(RecordArr[i].value(forKeyPath: "chanel_B") as! String)".ToFile(fileName: logHistoryFile)
            "\nTotal : \(RecordArr[i].value(forKeyPath: "total") as! String)".ToFile(fileName: logHistoryFile)
            "\n\n".ToFile(fileName: logHistoryFile)
        }
        if isShareLog {
            self.shareDialog()
        } else {
            toLogListVC()
        }
    }
    
    func shareDialog() {
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileUrl = dir!.appendingPathComponent(logHistoryFile)
        var filesToShare = [Any]()
        filesToShare.append(fileUrl)
                let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [.airDrop,
                                                                .postToFacebook,
                                                                .mail,
                                                                .postToTwitter,
                                                                .postToVimeo,
                                                                .postToFlickr,
                                                                .postToWeibo]
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - EXTENSIONS
extension HistoryVC:HistoryView{
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if RecordArr.count == 0{
            tblHistory.isHidden = true
            WarningView.isHidden = false
        }else{
            tblHistory.isHidden = false
            WarningView.isHidden = true
        }
        return RecordArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! historyCell
        
        cell.ChannelName_lbl.text = "Device".localizableString()//"Channel".localizableString()
        cell.Date_lbl.text = RecordArr[indexPath.row].value(forKeyPath: "created_date") as? String
        cell.ChannelA_lbl.text = RecordArr[indexPath.row].value(forKeyPath: "chanel_A") as? String
        cell.ChannelB_lbl.text = RecordArr[indexPath.row].value(forKeyPath: "chanel_B") as? String
        cell.DeviseName_lbl.text = RecordArr[indexPath.row].value(forKey: "device_name") as? String
        
        let total = RecordArr[indexPath.row].value(forKeyPath: "total") as? String
        let unit_type = RecordArr[indexPath.row].value(forKeyPath: "unit_type") as? String
        let app_type = RecordArr[indexPath.row].value(forKeyPath: "app_type") as? String
        cell.Total_lbl.text = "Total \(total!) \(unit_type!.localizableString().uppercased()) \(app_type!.localizableString().uppercased())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 245
    }
}

extension HistoryVC: InfoPopupDelegate {
    func onOKButtonTouchup() {
        DeleteAllData()
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Reload), userInfo: nil, repeats: false)
    }
    
    func onDismissButtonTouchup() {
        
    }
}
