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
        self.answers = self.sign.answers().subListWithRandomElements(maxLimit: Constants.Settings.maxAnswersCountInTest)
    } 
    
}
