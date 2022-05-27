//
//  DeviceListListRouter.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
protocol DeviceListRouter: UIViewControllerPresentation {
    
}

extension DeviceListVC: DeviceListRouter {
    func pushDeviceVC() {
        let nextVC = DeviceModule().viewController()
         navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func toLogListVC() {
        let nextVC = LogListModule().viewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showInfoPopup(titleString: String, messageString: String) {
        let infoPopup = InfoPopupModule(titleString: titleString, messageString: messageString).viewController() as! InfoPopupViewController
        infoPopup.delegate = self
        present(infoPopup, animated: true, completion: nil)
    }
}
