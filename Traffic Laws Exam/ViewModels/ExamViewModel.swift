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
    private var score = 0
    
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
    
    func testNumberString() -> String {
        return "\(currentTestIndex + 1)"
    }
    
    mutating func increaseScore(for spentTime: Int) {
        let maxPoints = Constants.Settings.correctAnswerMaxPoints
        let minPoints = Constants.Settings.correctAnswerMinPoints
        let duration = Constants.Settings.testDurationInSeconds
        let pointsPerSecond = (maxPoints - minPoints) / (duration - 1)
        let resultScore = (spentTime > 0) ? maxPoints - (spentTime) * pointsPerSecond : 200
        self.score += resultScore
    }
    
    func currentScoreString() -> String {
        return "\(score)"
    }
    
    func currentScore() -> Int {
        return score
    }
    
}
