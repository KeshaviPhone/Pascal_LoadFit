//
//  SettingModule.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit

final class SettingModule {
    
    // MARK: - Properties
    private let view: SettingVC
    private let presenter: SettingPresenter
    
    // MARK: - Init / Deinit methods
    init() {
        view = R.storyboard.main.settingVC()!
        presenter = SettingPresenter(with: view, router: view)
        view.presenter = presenter
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
