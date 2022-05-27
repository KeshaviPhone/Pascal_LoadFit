//
//  DeviceModule.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit

final class DeviceModule {
    
    // MARK: - Properties
    private let view: DeviceVC
    private let presenter: DevicePresenter
    
    // MARK: - Init / Deinit methods
    init() {
        view = R.storyboard.main.deviceVC()!
        presenter = DevicePresenter(with: view, router: view)
        view.presenter = presenter
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
