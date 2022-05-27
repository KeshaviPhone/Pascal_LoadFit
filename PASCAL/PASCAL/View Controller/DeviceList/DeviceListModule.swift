//
//  DeviceListListModule.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit

final class DeviceListModule {
    
    // MARK: - Properties
    private let view: DeviceListVC
    private let presenter: DeviceListPresenter
    
    // MARK: - Init / Deinit methods
    init() {
        view = R.storyboard.main.deviceListVC()!
        presenter = DeviceListPresenter(with: view, router: view)
        view.presenter = presenter
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
