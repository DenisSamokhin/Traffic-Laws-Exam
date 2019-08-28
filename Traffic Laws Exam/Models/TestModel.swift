//
//  TestModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/19/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation

class TestModel: NSObject {
    
    var sign: SignModel
    var answers: [SignModel]
    
    init(sign: SignModel) {
        self.sign = sign
        var otherAnswers = self.sign.answers().subListWithRandomElements(maxLimit: Constants.Settings.maxAnswersCountInTest - 1) // MaxLimit - 1 because we need to reserve 1 slot for the correct answer
        otherAnswers.append(sign)
        self.answers = otherAnswers.shuffled()
    } 
    
    func correctAnswer() -> String {
        return sign.title
    }
}
