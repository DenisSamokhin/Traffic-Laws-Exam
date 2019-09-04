//
//  ResultViewModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 9/4/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation
import UIKit

struct ResultViewModel {
    
    var currentExam: ExamModel
    var score: Int
    
    init(exam: ExamModel, score: Int) {
        self.currentExam = exam
        self.score = score
    }
    
    func currentScoreString() -> String {
        return "\(score)"
    }
}
