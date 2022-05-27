//
//  SideMenuPresenter.swift
//  PASCAL
//
//  Created by My Mac on 15/12/21.
//

import Foundation

final class SideMenuPresenter {
    
    // MARK: - Properties
    private weak var view: SideMenuView!
    private weak var router: SideMenuRouter!
    
    // MARK: - Init / Deinit methods
    init(with view: SideMenuView, router: SideMenuRouter) {
        self.view = view
        self.router = router
    }
    
    deinit {
        //
    }
}

extension SideMenuPresenter {

}
