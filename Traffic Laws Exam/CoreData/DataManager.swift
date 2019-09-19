//
//  DataManager.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let cdManager = CoreDataManager.init(modelName: "Traffic_Laws_Exam")
    
    private init(){}
    
    func saveData() {
        guard let context = cdManager.mainManagedObjectContext.parent else { return }
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func parseSampleData() {
        parseSignsData()
        parseCategoriesData()
        setCategoriesImages()
        generateSimilarSigns()
    }
    
    private func parseSignsData() {
        guard let signsUrl = Bundle.main.url(forResource: "signs", withExtension: "json") else { return }
        do {
            let jsonData = try Data(contentsOf: signsUrl)
            let arr = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [AnyObject]
            for object in arr {
                guard let obj = object as? [String : AnyObject],
                    let idNum = obj[Constants.JSONKeys.id] as? NSNumber,
                    let code = obj[Constants.JSONKeys.code] as? String,
                    let title = obj[Constants.JSONKeys.title] as? String,
                    let categoryId = obj[Constants.JSONKeys.categoryId] as? NSNumber
                    else { continue }
                if cdManager.checkSignForDuplicates(id: idNum) { continue }
                let sign = SignModel(context: cdManager.mainManagedObjectContext)
                sign.id = idNum.intValue
                sign.code = code
                sign.image = code
                sign.title = title
                sign.categoryId = categoryId.intValue
                sign.similarSigns = obj[Constants.JSONKeys.similarSigns] as? [Int]
                if sign.similarSigns == nil {
                    //print("-\n----- DATA SAMPLE ERROR: Similar Signs are missing for sign with ID: \(sign.id) and Title: \(sign.title)")
                }
                cdManager.saveMainContext()
            }
        }catch {
            
        }
    }
    
    private func parseCategoriesData() {
        guard let categoryUrl = Bundle.main.url(forResource: "categories", withExtension: "json") else { return }
        do {
            let jsonData = try Data(contentsOf: categoryUrl)
            let arr = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [AnyObject]
            for object in arr {
                guard let obj = object as? [String : AnyObject],
                    let idNum = obj[Constants.JSONKeys.id] as? NSNumber,
                    let title = obj[Constants.JSONKeys.title] as? String
                    else { continue }
                if cdManager.checkCategoryForDuplicates(id: idNum) { continue }
                let category = CategoryModel(context: cdManager.mainManagedObjectContext)
                category.id = idNum.intValue
                category.title = title
                category.image = ""
                cdManager.saveMainContext()
            }
        }catch {
            
        }
    }
    
    private func setCategoriesImages() {
        let categories = getCategoriesList()
        for category in categories {
            let signs = getSignsList(categoryId: category.id)
            if signs.count > 0 {
                if let sign = signs.first {
                    category.image = sign.code
                    cdManager.saveMainContext()
                }
            }
        }
    }
    
    private func generateSimilarSigns() {
        // If similarSigns is nil or empty,then populate it with signs of its category, exclude signs with the same title
        let signs = getSignsList(categoryId: 0)
        for sign in signs {
            if sign.similarSigns == nil {
                // Get signs list of the same category
                let list = getSignsList(categoryId: sign.categoryId)
                var filteredList = [SignModel]()
                // Filter the list
                for item in list {
                    var exists = false
                    // Do not include signs with the correct answer title
                    if item.title == sign.title {
                        continue
                    }
                    for x in filteredList {
                        // Check if sign already exists in filtered array
                        if x.title == item.title {
                            exists = true
                            break
                        }
                    }
                    if !exists {
                        // Add sign to filtered list
                        filteredList.append(item)
                    }
                }
                // Convert list form [SignModel] to [Int] of sign IDs
                sign.similarSigns = filteredList.map({$0.id})
                cdManager.saveMainContext()
            }
        }
    }
    
    // MARK: - Getters
    
    func getSignsList(categoryId: Int?) -> [SignModel] {
        return cdManager.getSignsList(categoryId: categoryId)
    }
    
    func getCategoriesList() -> [CategoryModel] {
        return cdManager.getCategoriesList()
    }
    
    func getSign(id: Int) -> SignModel? {
        return cdManager.getSign(id: id)
    }
    
    // MARK: - Exams
    
    func createEmptyExam() -> ExamModel {
        // Calculate id for new exam object and set it
        let exam = ExamModel(context: cdManager.mainManagedObjectContext)
        exam.id = cdManager.newId(for: Constants.CoreDataKeys.exams)
        return exam
    }
    
    
    func saveExam() {
        cdManager.saveMainContext()
    }
    
    func getStoredExams() -> [ExamModel] {
        return cdManager.getStoredExams()
    }
    
}
