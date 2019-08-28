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
    
    init(exam: ExamModel) {
        self.currentExam = exam
    }
    
    func title(forAnswerIndex answerIndex: Int, testIndex: Int) -> String {
        return self.currentExam.tests[testIndex].answers[answerIndex].title
    }
    
}
