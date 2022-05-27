//
//  DevicePresenter.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import UIKit

final class DevicePresenter {
    
    // MARK: - Properties
    private weak var view: DeviceView!
    private weak var router: DeviceRouter!
    
    // MARK: - Init / Deinit methods
    init(with view: DeviceView, router: DeviceRouter) {
        self.view = view
        self.router = router
    }
    
    deinit {
        //
    }
}
extension DevicePresenter
{
    
}
