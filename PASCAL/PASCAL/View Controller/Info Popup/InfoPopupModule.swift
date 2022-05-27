//
//  InfoPopupModule.swift
//  Ev BlocShare
//
//  Created by My Mac on 08/03/22.
//

import Foundation
import UIKit

final class InfoPopupModule {
    
    // MARK: - Properties
    private let view: InfoPopupViewController
    private let presenter: InfoPopupPresenter
    
    // MARK: - Init / Deinit methods
    init(titleString: String, messageString: String) {
        view = R.storyboard.main.infoPopupViewController()!
        presenter = InfoPopupPresenter(with: view, router: view)
        view.presenter = presenter
        view.titleString = titleString
        view.messageString = messageString
    }
    
    // MARK: - Public methods
    func viewController() -> UIViewController {
        return view
    }
}
