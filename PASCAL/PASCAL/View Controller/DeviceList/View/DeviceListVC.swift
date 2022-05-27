//
//  DeviceListListVC.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit
import SideMenu
import CoreBluetooth
import DropDown
import MaterialProgressBar

var manager: CBCentralManager? = nil
var discoveredPeripheral: CBPeripheral?

protocol DeviceListView: AnyObject {
    
}

class DeviceListCell: UITableViewCell {
    @IBOutlet weak var bluetoothNameLabel: UILabel!
}

class DeviceListVC: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - GLOBAL VARIABLES
    var peripherals:[CBPeripheral] = []
    
    var presenter:DeviceListPresenter!
    let menuView = SideMenuVC()
    var menu: SideMenuNavigationController?
    var isiOSBluetoothOn = false
    
    let progressBar = LinearProgressBar()
    
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var Scan_outlet: UIButton!
    @IBOutlet weak var Bluetoth_lbl: UILabel!
    @IBOutlet weak var btnPopup: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDeviceView: UIView!
    
    @IBOutlet weak var outputText: UITextView!
    @IBOutlet weak var logView: UIView!
    
    let OnDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.OnDropDown
        ]
    }()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = nil
        discoveredPeripheral = nil
        
        menu = SideMenuNavigationController(rootViewController: menuView)
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        ChooseOnDropDown()
        
        manager = CBCentralManager(delegate: self, queue: nil)
        manager!.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        progressView.addSubview(progressBar)
        progressBar.frame = CGRect(x: 0, y: 0, width: progressView.frame.size.width, height: progressView.frame.size.height)
        progressBar.progressBarWidth = 4
        progressBar.startAnimating()
        hideProgress()
    }
    
    func showProgress() {
        progressView.alpha = 1
        progressBar.startAnimating()
    }
    
    func hideProgress() {
        progressView.alpha = 0
        progressBar.stopAnimating()
    }
    
    private func retrievePeripheral() {
        print("retrievePeripheral()")
        log(text: "retrievePeripheral()")
        let connectedPeripherals: [CBPeripheral] = (manager!.retrieveConnectedPeripherals(withServices: [TransferService.serviceUUID]))
        
        if let connectedPeripheral = connectedPeripherals.last {
            discoveredPeripheral = connectedPeripheral
            discoveredPeripheral?.delegate = self
            manager!.connect(connectedPeripheral, options: nil)
        } else {
#if !targetEnvironment(simulator)
            scanBLEDevice()
#endif
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnMenu.setTitle("DEVICE LIST".localizableString(), for: .normal)
        Bluetoth_lbl.text = "No device found, plese scan again!".localizableString()
        Scan_outlet.setTitle("Scan".localizableString(), for: .normal)
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
    
    @IBAction func Scan(_ sender: Any) {
#if targetEnvironment(simulator)
        self.pushDeviceVC()
#else
        if (sender as! UIButton).titleLabel?.text == "Stop".localizableString() {
            manager?.stopScan()
            Scan_outlet.setTitle("Scan".localizableString(), for: .normal)
            hideProgress()
        } else {
            scanBLEDevice()
        }
#endif
    }
    
    @IBAction func closeLog(_ sender: UIButton) {
        logView.isHidden = true
    }
    
    @IBAction func showLog(_ sender: UIButton) {
        logView.isHidden = false
    }
    
    @objc func Reload()
    {
        let nextVC = DeviceListModule().viewController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    // MARK: - Private Methods
    
    func log(text: String) {
        let newDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm:ss")
        let displayDate = dateFormatter.string(from: newDate) + ": "
        
        let newLogText = (self.outputText.text ?? "\n") + displayDate + text + "\n"
        
        self.outputText.text = newLogText
        self.outputText.scrollRangeToVisible(NSMakeRange(self.outputText.text.count - 1,0))
    }
    
    func scanBLEDevice()
    {
        manager?.scanForPeripherals(withServices: [TransferService.serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        Scan_outlet.setTitle("Stop".localizableString(), for: .normal)
        showProgress()
        //manager?.scanForPeripherals(withServices: nil, options: nil)
    }
}

// MARK: - EXTENSIONS

extension DeviceListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceListCell", for: indexPath) as! DeviceListCell
        cell.selectionStyle = .none
        let peripheral = peripherals[indexPath.row]
        cell.bluetoothNameLabel.text = peripheral.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = peripherals[indexPath.row]
        manager?.stopScan()
        Scan_outlet.setTitle("Scan".localizableString(), for: .normal)
        hideProgress()
        discoveredPeripheral = peripheral
        peripheral.delegate = self
        manager?.connect(peripheral, options: nil)
    }
}

extension DeviceListVC:DeviceListView
{
    
}

extension DeviceListVC: CBPeripheralDelegate, CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState( _ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
            log(text: "central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
            log(text: "central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
            log(text: "central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
            log(text: "central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
            log(text: "central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            log(text: "central.state is .poweredOn")
            retrievePeripheral()
        @unknown default:
            fatalError()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if (!peripherals.contains(peripheral)){
            if let name = peripheral.name {
                if name.hasPrefix("K4") {
                    peripherals.append(peripheral)
                }
            }
        }
        noDeviceView.isHidden = true
        self.tableView.reloadData()
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("connected to \(peripheral)")
        log(text: "connected to \(peripheral)")
        
        if peripheral == discoveredPeripheral {
            peripheral.discoverServices([TransferService.serviceUUID])
        }
        
        print("centralManager:didConnect() identifier --> \(peripheral.identifier.description)")
        log(text: "centralManager:didConnect() identifier --> \(peripheral.identifier.description)")
        
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
        log(text: "Enabling notify \(characteristic.uuid)")
        
        if error != nil {
            print("Enable notify error --> \(String(describing: error?.localizedDescription))")
            log(text: "Enable notify error --> \(String(describing: error?.localizedDescription))")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if let error = error {
            print("Error discovering characteristics: %s", error.localizedDescription)
            log(text: "Error discovering characteristics: \(error.localizedDescription)")
            return
        }
        
        guard let characteristicData = characteristic.value,
              let stringFromData = String(data: characteristicData, encoding: .utf8) else { return }
        
        print("Received \(characteristicData.count) bytes: \(stringFromData)")
        log(text: "Received \(characteristicData.count) bytes: \(stringFromData)")
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if peripheral.name != nil {
            print("didDiscoverPerifpheral = \(peripheral.name!)")
        }
        
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
            log(text: "Found characteristic --> \(characteristic)")
            
            if characteristic.uuid == TransferService.readCharacteristicUUID {
                print("Read characteristic found")
                log(text: "Read characteristic found")
                peripheral.setNotifyValue(true, for: characteristic)
            } else if characteristic.uuid == TransferService.writeCharacteristicUUID {
                print("Write characteristic found")
                log(text: "Write characteristic found")
                //self.writeCharacteristic = characteristic
                //peripheral.setNotifyValue(true, for: characteristic)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //DispatchQueue.main.async {
            print("*BOX/SSTATUS/GET/DATA# --> Command Sent")
            self.log(text: "*BOX/SSTATUS/GET/DATA# --> Command Sent")
            //            let statusCommand = "*BOX/SSTATUS/GET/DATA#"
            //            let data = Data(statusCommand.utf8)
            self.pushDeviceVC()
        }
    }
}

struct TransferService {
    
    static let serviceUUID = CBUUID(string: "0000fff0-0000-1000-8000-00805f9b34fb")
    static let readCharacteristicUUID = CBUUID(string: "0000fff1-0000-1000-8000-00805f9b34fb")
    static let writeCharacteristicUUID = CBUUID(string: "0000fff2-0000-1000-8000-00805f9b34fb")
}

extension DeviceListVC: InfoPopupDelegate {
    func onOKButtonTouchup() {
        DeleteAllData()
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.Reload), userInfo: nil, repeats: false)
    }
    
    func onDismissButtonTouchup() {
        
    }
}
