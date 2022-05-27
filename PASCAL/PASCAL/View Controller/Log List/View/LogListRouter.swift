//
//  LogListRouter.swift
//  PASCAL
//
//  Created by Jecky Kukadiya on 15/03/22.
//

import Foundation

protocol LogListRouter: UIViewControllerPresentation {
    
}

extension LogListVC: LogListRouter {
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
