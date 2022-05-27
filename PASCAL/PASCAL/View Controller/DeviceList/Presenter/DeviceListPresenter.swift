//
//  DeviceListListPresenter.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import UIKit

final class DeviceListPresenter {
    
    // MARK: - Properties
    private weak var view: DeviceListView!
    private weak var router: DeviceListRouter!
    
    // MARK: - Init / Deinit methods
    init(with view: DeviceListView, router: DeviceListRouter) {
        self.view = view
        self.router = router
    }
    
    deinit {
        //
    }
}
extension DeviceListPresenter
{
    
}
