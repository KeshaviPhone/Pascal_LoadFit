//
//  InfoPopupPresenter.swift
//  Ev BlocShare
//
//  Created by My Mac on 08/03/22.
//

import Foundation

final class InfoPopupPresenter {
    
    // MARK: - Properties
    private weak var view: InfoPopupView!
    private weak var router: InfoPopupRouter!
    
    // MARK: - Init / Deinit methods
    init(with view: InfoPopupView, router: InfoPopupRouter) {
        self.view = view
        self.router = router
    }
    
    deinit {
        //
    }
}

extension InfoPopupPresenter
{
    
}
