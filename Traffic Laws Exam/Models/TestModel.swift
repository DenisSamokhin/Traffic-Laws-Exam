//
//  TestModel.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/19/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import Foundation

class TestModel: NSObject, NSCoding {
    
    var answers: [String]
    var correctAnswer: String
    var image: String
    var signId: Int
    var selectedAnswer: String?
    
    init(sign object: SignModel) {
        self.signId = object.id
        self.correctAnswer = object.title
        self.image = object.image
        var otherAnswers = object.answers().subListWithRandomElements(maxLimit: Constants.Settings.maxAnswersCountInTest - 1) // MaxLimit - 1 because we need to reserve 1 slot for the correct answer
        otherAnswers.append(object)
        self.answers = otherAnswers.shuffled().map({$0.title})
    }
    
    // MARK: - NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(correctAnswer, forKey: Constants.JSONKeys.correctAnswer)
        aCoder.encode(selectedAnswer, forKey: Constants.JSONKeys.selectedAnswer)
        aCoder.encode(answers, forKey: Constants.JSONKeys.answers)
        aCoder.encode(image, forKey: Constants.JSONKeys.image)
        aCoder.encode(Int64(signId), forKey: Constants.JSONKeys.id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.correctAnswer = aDecoder.decodeObject(forKey: Constants.JSONKeys.correctAnswer) as! String
        self.selectedAnswer = aDecoder.decodeObject(forKey: Constants.JSONKeys.selectedAnswer) as? String
        self.answers = aDecoder.decodeObject(forKey: Constants.JSONKeys.answers) as! [String]
        self.image = aDecoder.decodeObject(forKey: Constants.JSONKeys.image) as! String
        self.signId = Int(aDecoder.decodeInt64(forKey: Constants.JSONKeys.id))
    }
}
