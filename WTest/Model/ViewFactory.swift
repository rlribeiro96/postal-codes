//
//  ViewFactory.swift
//  WTest
//
//  Created by Ricardo Ribeiro on 10/10/22.
//

import Foundation
import UIKit

class ViewFactory {
    static func makeView() -> UIViewController {
        //ViewController
        let viewController = PostalListViewController()
        
        //CoreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataManager = CoreDataManager(appDelegate: appDelegate)
        
        //ViewModel
        let viewModel = PostalListViewModel(coreDataManager: coreDataManager, loadingDelegate: viewController)
        viewController.viewModel = viewModel
        
        return viewController
      }
}
