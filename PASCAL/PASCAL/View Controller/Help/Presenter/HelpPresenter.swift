//
//  HelpPresenter.swift
//  PASCAL
//
//  Created by My Mac on 15/12/21.
//

import UIKit

final class HelpPresenter {
    
    // MARK: - Properties
    private weak var view: HelpView!
    private weak var router: HelpRouter!
    
    // MARK: - Init / Deinit methods
    init(with view: HelpView, router: HelpRouter) {
        self.view = view
        self.router = router
    }
    
    deinit {
        //
    }
}
extension HelpPresenter
{
    
}
