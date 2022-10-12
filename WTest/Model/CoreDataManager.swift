//
//  CoreDataManager.swift
//  WTest
//
//  Created by Ricardo Ribeiro on 08/10/22.
//

import CoreData
import TabularData
import UIKit

public protocol CoreDataManagerProtocol {
    func saveFromFile(url: URL)
    func fetchPostalCode(searchTerm: String) -> [String]
}

class CoreDataManager: CoreDataManagerProtocol {
    private let context: NSManagedObjectContext
    
    init(appDelegate: AppDelegate) {
        context = appDelegate.persistentContainer.viewContext
        //context = appDelegate.persistentContainer.newBackgroundContext()
    }
    
    func saveFromFile(url: URL) {
        
        let data = try! DataFrame.init(contentsOfCSVFile: url)
        
        for row in data.rows {
            let numCodPostal = row[14]!
            let extCodPostal = row[15]!
            let desigPostal = row[16]!
            
            let postalCodeModel = PostalCodeModel(info: "\(numCodPostal)-\(extCodPostal) \(desigPostal)")
            savePostalCode(postalCodeModel: postalCodeModel)
        }
    }
    
    private func savePostalCode(postalCodeModel: PostalCodeModel) {
        let postalCode = NSEntityDescription.insertNewObject(forEntityName: "PostalCode", into: self.context)
        postalCode.setValue(postalCodeModel.info, forKey: "postal_code_info")
        
        do {
            try self.context.save()
            print("saved to CoreData successfully")
        } catch {
            print("failed to save entity to CoreData")
        }
    }
    
    func fetchPostalCode(searchTerm: String) -> [String] {
        var resultList: [String] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"PostalCode")
        let predicate: NSPredicate = NSPredicate(format: "postal_code_info CONTAINS[cd] %@", searchTerm)
        fetchRequest.predicate = predicate
        
        do {
            let postalCodes = try self.context.fetch(fetchRequest)
            
            for p in postalCodes as! [NSManagedObject] {
                if let postalCodeInfo = p.value(forKey: "postal_code_info") {
                    resultList.append(postalCodeInfo as! String)
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
        return resultList
    }
}

