//
//  LogListVC.swift
//  PASCAL
//
//  Created by Jecky Kukadiya on 15/03/22.
//

import UIKit

protocol LogListView: AnyObject {
    func getURLs(urls: [URL], success: Bool)
}

class logsFileCell: UITableViewCell {
    @IBOutlet weak var logFileNameLabel: UILabel!
}

class LogListVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var logFilesTable: UITableView!
    
    var urlArray = [URL]()
    var presenter: LogListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logFilesTable.tableFooterView = UIView()
        presenter.getlogFiles()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTouchUp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func shareDialog(url: URL) {
        var filesToShare = [Any]()
        filesToShare.append(url)
                let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                
                // exclude some activity types from the list (optional)
                activityViewController.excludedActivityTypes = [.airDrop,
                                                                .postToFacebook,
                                                                .mail,
                                                                .postToTwitter,
                                                                .postToVimeo,
                                                                .postToFlickr,
                                                                .postToWeibo]
                // present the view controller
                self.present(activityViewController, animated: true, completion: nil)
    }
    
}

extension LogListVC: LogListView {
    func getURLs(urls: [URL], success: Bool) {
        urlArray = urls
    }
}

extension LogListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logsFileCell", for: indexPath) as! logsFileCell
        cell.logFileNameLabel.text = urlArray[indexPath.row].lastPathComponent
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shareDialog(url: urlArray[indexPath.row])
    }
    
}
