//
//  CoreDataManager.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    var modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Pulling
    
    func getSignsList() -> [SignModel] {
        let request = NSFetchRequest<SignModel>(entityName: Constants.CoreDataKeys.signs)
        do {
            let result = try self.privateManagedObjectContext.fetch(request)
            return result
        }catch {
            print("getSignsList() FAILED")
            return [SignModel]()
        }
    }
    
    func getCategoriesList() -> [CategoryModel] {
        let request = NSFetchRequest<CategoryModel>(entityName: Constants.CoreDataKeys.categories)
        do {
            let result = try self.privateManagedObjectContext.fetch(request)
            return result
        }catch {
            print("getCategoriesList() FAILED")
            return [CategoryModel]()
        }
    }
    
    // MARK: - CoreData Stack
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            return nil
        }
        
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        
        return managedObjectModel
    }()
    
    private var persistentStoreURL: NSURL {
        let storeName = "\(modelName).sqlite"
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        return documentsDir.appendingPathComponent(storeName) as NSURL
    }
    
    private lazy var persistentStoCoordinator: NSPersistentStoreCoordinator? = {
        guard let managedModel = self.managedObjectModel else { return nil }
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedModel) as NSPersistentStoreCoordinator
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL as URL, options: options)
        }catch {
            let error = error as NSError
            print("\(error.localizedDescription)")
        }
        return persistentStoreCoordinator
    }()
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoCoordinator
        return managedObjectContext
    }()
    
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.privateManagedObjectContext
        return managedObjectContext
    }()
    
    
    
}
