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
        
        return exam
    }

}
