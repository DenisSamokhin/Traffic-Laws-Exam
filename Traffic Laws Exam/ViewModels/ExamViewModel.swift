//
//  TestViewModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/19/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation
import UIKit

struct ExamViewModel {
    
    var currentExam: ExamModel
    private var currentTestIndex = 0
    
    init(exam: ExamModel) {
        self.currentExam = exam
    }
    
    func currentTest() -> TestModel {
        return self.currentExam.tests[currentTestIndex]
    }
    
    mutating func goToNextTest() {
        currentTestIndex += 1
    }
    
    func isLastTest() -> Bool {
        return currentTestIndex == currentExam.tests.count - 1
    }
    
}
