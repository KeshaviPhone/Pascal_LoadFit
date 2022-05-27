//
//  InfoPopupRouter.swift
//  Ev BlocShare
//
//  Created by My Mac on 08/03/22.
//

import Foundation
import UIKit

protocol InfoPopupRouter: UIViewControllerPresentation {
    
}

extension InfoPopupViewController: InfoPopupRouter {
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
