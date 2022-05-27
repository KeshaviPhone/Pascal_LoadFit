//
//  LogListModule.swift
//  PASCAL
//
//  Created by Jecky Kukadiya on 15/03/22.
//

import Foundation
import UIKit

final class LogListModule {
    
    // MARK: - Properties
    private let view: LogListVC
    private let presenter: LogListPresenter
    
    // MARK: - Init / Deinit methods
    init() {
        view = R.storyboard.main.logListVC()!
        presenter = LogListPresenter(with: view, router: view)
        view.presenter = presenter
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
