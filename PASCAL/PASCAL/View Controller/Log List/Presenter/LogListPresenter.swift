//
//  LogListPresenter.swift
//  PASCAL
//
//  Created by Jecky Kukadiya on 15/03/22.
//

import Foundation

final class LogListPresenter {
    
    // MARK: - Properties
    private weak var view: LogListView!
    private weak var router: LogListRouter!
    
    // MARK: - Init / Deinit methods
    init(with view: LogListView, router: LogListRouter) {
        self.view = view
        self.router = router
    }
    
    deinit {
        //
    }
}

extension LogListPresenter
{
    func getlogFiles() {
        do {
            // Get the document directory url
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            print("documentDirectory", documentDirectory.path)
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(
                at: documentDirectory,
                includingPropertiesForKeys: nil
            )
            var tempArray = [URL]()
            for url in directoryContents {
                print(url.lastPathComponent)
                if url.lastPathComponent.contains("History") {
                    tempArray.append(url)
                }
            }
            self.view.getURLs(urls: tempArray, success: true)
        } catch {
            print(error)
        }
    }
}
