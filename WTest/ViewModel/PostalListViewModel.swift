//
//  PostalListViewmodel.swift
//  WTest
//
//  Created by Ricardo Ribeiro on 08/10/22.
//

import Foundation
import Alamofire

class PostalListViewModel {
    
    var searchResult: [String] = []
    let coreDataManager: CoreDataManagerProtocol
    let loadingDelegate: LoadingIndicatorProtocol?

    private let postalListURL = "https://github.com/centraldedados/codigos_postais/raw/master/data/codigos_postais.csv"
    private let fileName = "codigos_postais.csv"
    
    private var fileURL: URL {
        return try! FileManager().url(for: .documentDirectory,
                                      in: .userDomainMask,
                                      appropriateFor: nil,
                                      create: true).appendingPathComponent(fileName)
    }
    
    init(coreDataManager: CoreDataManagerProtocol, loadingDelegate: LoadingIndicatorProtocol?) {
        self.coreDataManager = coreDataManager
        self.loadingDelegate = loadingDelegate
    }
    
    func downloadPostalListFile() {
        if !FileManager().fileExists(atPath: fileURL.path) {
            loadingDelegate?.showLoading()
            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
            
            AF.download(postalListURL, to: destination).response { response in
                if response.error == nil {
                    print("Successfully downloaded file.")
                    self.coreDataManager.saveFromFile(url: self.fileURL)
                    self.loadingDelegate?.hideLoading()
                } else {
                    print(response.error ?? "generic error")
                }
            }
        }
    }
    
    func searchPostalCodes(searchTerm: String) {
        searchResult = coreDataManager.fetchPostalCode(searchTerm: searchTerm)
    }
}
