//
//  HistoryModule.swift
//  PASCAL
//
//  Created by My Mac on 14/12/21.
//

import Foundation
import UIKit

final class HistoryModule {
    
    // MARK: - Properties
    private let view: HistoryVC
    private let presenter: HistoryPresenter
    
    // MARK: - Init / Deinit methods
    init() {
        view = R.storyboard.main.historyVC()!
        presenter = HistoryPresenter(with: view, router: view)
        view.presenter = presenter
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
