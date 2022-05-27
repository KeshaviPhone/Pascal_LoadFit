//
//  InfoPopupViewController.swift
//  Ev BlocShare
//
//  Created by My Mac on 08/03/22.
//

import UIKit

protocol InfoPopupView: AnyObject {
    
}

protocol InfoPopupDelegate {
    func onOKButtonTouchup()
    func onDismissButtonTouchup()
}

class InfoPopupViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var presenter: InfoPopupPresenter!
    var titleString = ""
    var messageString = ""
    var delegate: InfoPopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = titleString
        messageLabel.text = messageString
    }
    
    //MARK: - Button Actions
    @IBAction func okButtonTouchUp(_ sender: Any) {
        DeleteAllData()
        delegate?.onOKButtonTouchup()
        dismissView()
    }
    
    @IBAction func dismissButtonTouchUp(_ sender: Any) {
        dismissView()
    }
    
}

extension InfoPopupViewController: InfoPopupView {
    
}

