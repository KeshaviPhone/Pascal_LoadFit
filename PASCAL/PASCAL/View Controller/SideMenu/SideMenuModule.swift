//
//  SideMenuModule.swift
//  PASCAL
//
//  Created by My Mac on 15/12/21.
//

import Foundation
import UIKit

final class SideMenuModule {
    
    // MARK: - Properties
    private let view: SideMenuVC
    private let presenter: SideMenuPresenter
    
    // MARK: - Init / Deinit methods
    init() {
        view = R.storyboard.main.sideMenuVC()!
        presenter = SideMenuPresenter(with: view, router: view)
        view.presenter = presenter
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
