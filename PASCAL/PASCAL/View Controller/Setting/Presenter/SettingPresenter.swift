//
//  SettingPresenter.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import UIKit

final class SettingPresenter {
    
    // MARK: - Properties
    private weak var view: SettingView!
    private weak var router: SettingRouter!
    
    // MARK: - Init / Deinit methods
    init(with view: SettingView, router: SettingRouter) {
        self.view = view
        self.router = router
    }
    
    deinit {
        //
    }
}
extension SettingPresenter
{
    
}
