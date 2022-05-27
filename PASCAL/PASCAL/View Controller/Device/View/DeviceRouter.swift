//
//  DeviceRouter.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
protocol DeviceRouter: UIViewControllerPresentation {
    
}

extension DeviceVC: DeviceRouter {
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
