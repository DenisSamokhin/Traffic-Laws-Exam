//
//  ExamManager.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/19/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation

class ExamManager {
    
    static let shared = ExamManager()

    private init(){}
    
    func createExam(categoryId: Int) -> ExamModel {
        let exam = DataManager.shared.createEmptyExam()
        exam.categoryId = categoryId
        let signsList = DataManager.shared.getSignsList(categoryId: categoryId)
        let filteredList = generateExamSignsList(from: signsList)
        let testsList = filteredList.map({
            return TestModel(sign: $0)
        })
        exam.tests = testsList
        return exam
    }
    
    func generateExamSignsList(from signsList: [SignModel]) -> [SignModel] {
        return signsList.subListWithRandomElements(maxLimit: Constants.Settings.maxTestsCountInExam)
    }
    

}
