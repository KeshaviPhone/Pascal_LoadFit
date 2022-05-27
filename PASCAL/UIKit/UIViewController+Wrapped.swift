//
//  UIViewController+Wrapped.swift
//  PASCAL
//
//  Created by My Mac on 07/10/21.
//

import Foundation
import UIKit.UIViewController

extension UIViewController {
    
    var wrapped: UINavigationController {
        let wrappedViewController = UINavigationController(rootViewController: self)
        wrappedViewController.isNavigationBarHidden = true
        return wrappedViewController
    }
}
