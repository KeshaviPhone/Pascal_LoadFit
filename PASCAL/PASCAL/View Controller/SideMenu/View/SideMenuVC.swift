//
//  SideMenuVC.swift
//  PASCAL
//
//  Created by My Mac on 15/12/21.
//

import UIKit

protocol SideMenuView: AnyObject {
    
}

class sideMenuCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
}

class SideMenuVC: UIViewController {
    
    var presenter: SideMenuPresenter!
    var arrimage:[UIImage] = [#imageLiteral(resourceName: "wifi"),#imageLiteral(resourceName: "kilogram"),#imageLiteral(resourceName: "histr"),#imageLiteral(resourceName: "set"),#imageLiteral(resourceName: "help")]
    var arrName = ["Scale connection","Weights","History","Settings","Help"]
    @IBOutlet weak var tblSideMenu: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

extension SideMenuVC: SideMenuView {
    
}

extension SideMenuVC: UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return arrName.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tblSideMenu.dequeueReusableCell(withIdentifier: "cell") as! sideMenuCell
         cell.imgView.image = arrimage[indexPath.row]
         cell.lblName.text = arrName[indexPath.row].localizableString()
         cell.selectionStyle = .none
         return cell
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         switch indexPath.row {
         case 0:
             pushDeviceListVC()
         case 1:
             if discoveredPeripheral != nil && discoveredPeripheral!.state == .connected {
                 pushDeviceVC()
             } else {
                 pushDeviceListVC()
             }
         case 2:
            pushHistoryVC()
         case 3:
            pushSettingVC()
         case 4:
            pushHelpVC()
         default:
             print("Error")
         }
     }
}
