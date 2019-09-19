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
    
    func getSignsList(categoryId: Int?) -> [SignModel] {
        var category = 0 // If category id is nil then return all categories
        if let catId = categoryId {
            category = catId
        }
        let request = NSFetchRequest<SignModel>(entityName: Constants.CoreDataKeys.signs)
        if category != 0 {
            let predicate = NSPredicate(format: "categoryId == %d", category)
            request.predicate = predicate
        }
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            return result
        }catch {
            print("getSignsList() FAILED")
            return [SignModel]()
        }
    }
    
    func getCategoriesList() -> [CategoryModel] {
        let request = NSFetchRequest<CategoryModel>(entityName: Constants.CoreDataKeys.categories)
        let sort = NSSortDescriptor(key: #keyPath(CategoryModel.id), ascending: true)
        request.sortDescriptors = [sort]
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            return result
        }catch {
            print("getCategoriesList() FAILED")
            return [CategoryModel]()
        }
    }
    
    func getSign(id: Int) -> SignModel? {
        let request = NSFetchRequest<SignModel>(entityName: Constants.CoreDataKeys.signs)
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            return result.first
        }catch {
            print("getSign() FAILED")
            return nil
        }
    }
    
    func getCategory(id: Int) -> CategoryModel? {
        let request = NSFetchRequest<CategoryModel>(entityName: Constants.CoreDataKeys.categories)
        let predicate = NSPredicate(format: "id == %d", id)
        request.predicate = predicate
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            return result.first
        }catch {
            print("getCategory() FAILED")
            return nil
        }
    }
    
    func getStoredExams() -> [ExamModel] {
        let request = NSFetchRequest<ExamModel>(entityName: Constants.CoreDataKeys.exams)
        let sort = NSSortDescriptor(key: #keyPath(ExamModel.datePassed), ascending: false)
        request.sortDescriptors = [sort]
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            return result
        }catch {
            print("getStoredExams() FAILED")
            return [ExamModel]()
        }
    }
    
    // MARK: - Generate id
    
    func newId(for entity: String) -> Int {
        let request = NSFetchRequest<ExamModel>(entityName: Constants.CoreDataKeys.exams)
        let sort = NSSortDescriptor(key: #keyPath(ExamModel.id), ascending: true)
        request.sortDescriptors = [sort]
        var index = 0
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            if let lastExam = result.last {
                index = lastExam.id + 1
            }
            return index
        }catch {
            print("getSignsList() FAILED")
            return index
        }
    }
    
    func checkSignForDuplicates(id: NSNumber) -> Bool {
        let request = NSFetchRequest<SignModel>(entityName: Constants.CoreDataKeys.signs)
        let predicate = NSPredicate(format: "id == %d", id.intValue)
        request.predicate = predicate
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            return result.count > 0
        }catch {
            print("getSignsList() FAILED")
            return false
        }
    }
    
    func checkCategoryForDuplicates(id: NSNumber) -> Bool {
        let request = NSFetchRequest<CategoryModel>(entityName: Constants.CoreDataKeys.categories)
        let predicate = NSPredicate(format: "id == %d", id.intValue)
        request.predicate = predicate
        do {
            let result = try self.mainManagedObjectContext.fetch(request)
            return result.count > 0
        }catch {
            print("getSignsList() FAILED")
            return false
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
    
    func saveMainContext() {
        do {
            try self.mainManagedObjectContext.save()
        }catch {
            print("Core Data save error")
        }
        if self.privateManagedObjectContext.hasChanges {
            do {
                try self.privateManagedObjectContext.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
}
