//
//  ModuleInitializable.swift
//  PASCAL
//
//  Created by My Mac on 07/10/21.
//

import UIKit

public protocol BaseModule {
    func viewController() -> UIViewController
}

typealias ModuleInitializable = BaseModule & Initializable

protocol Initializable {
    init()
}

extension Initializable {
    
    static var stringValue: String {
        return String(describing: self)
    }
}
