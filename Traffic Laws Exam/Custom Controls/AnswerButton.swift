//
//  AnswerButton.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/28/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    
    enum AnswerType {
        case neutral
        case wrong
        case correct
    }
    
    var answer: SignModel
    var cornerRadius: CGFloat
    
    init(_ cornerRadius: CGFloat = 5.0, answer: SignModel) {
        self.cornerRadius = cornerRadius
        self.answer = answer
        super.init(frame: .zero)
        self.setTitle(answer.title, for: .normal)
        setupDefaultUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDefaultUI() {
        self.backgroundColor = ButtonSettings.Colors.AnswerButton.NeutralType.bgColor
        self.setTitleColor(ButtonSettings.Colors.AnswerButton.NeutralType.textColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    func change(answerType type: AnswerType) {
        switch type {
        case .neutral:
            self.backgroundColor = ButtonSettings.Colors.AnswerButton.NeutralType.bgColor
            self.setTitleColor(ButtonSettings.Colors.AnswerButton.NeutralType.textColor, for: .normal)
        case .wrong:
            self.backgroundColor = ButtonSettings.Colors.AnswerButton.WrongType.bgColor
            self.setTitleColor(ButtonSettings.Colors.AnswerButton.WrongType.textColor, for: .normal)
        case . correct:
            self.backgroundColor = ButtonSettings.Colors.AnswerButton.CorrectType.bgColor
            self.setTitleColor(ButtonSettings.Colors.AnswerButton.CorrectType.textColor, for: .normal)
        default:
            self.backgroundColor = ButtonSettings.Colors.AnswerButton.NeutralType.bgColor
            self.setTitleColor(ButtonSettings.Colors.AnswerButton.NeutralType.textColor, for: .normal)
        }
    }
    
    func highlightCorrectAnswer() {
        UIView.animate(withDuration: 0.5, delay: 0, options:[UIView.AnimationOptions.repeat], animations: {
            self.backgroundColor = ButtonSettings.Colors.AnswerButton.NeutralType.bgColor
            self.backgroundColor = ButtonSettings.Colors.AnswerButton.CorrectType.bgColor
        }, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.layer.removeAllAnimations()
        })
    }
}
