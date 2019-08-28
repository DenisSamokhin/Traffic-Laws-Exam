//
//  ExamViewController.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/19/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {
    
    var viewModel: ExamViewModel
    
    var testContainerView: UIView?
    var signImageView: UIImageView?
    var button1: AnswerButton?
    var button2: AnswerButton?
    var button3: AnswerButton?
    var buttonsContainer: UIView?
    
    
    // MARK: - Initialiation
    
    init(viewModel: ExamViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Exam"
        self.view.backgroundColor = UIColor.white
        setUI()
    }
    
    // MARK: - UI
    
    func setUI() {
        setTestContainerView()
        setButtons()
        setSignImageView()
    }
    
    func setTestContainerView() {
        
        if testContainerView != nil { return }
        
        testContainerView = UIView()
        guard let container = testContainerView else { return }
        container.backgroundColor = UIColor.clear
        container.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(container)
        
        container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        container.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
    }
    
    func setButtons() {
        
        buttonsContainer = UIView()
        guard let container = testContainerView, let buttonsContainer = buttonsContainer else { return }
        buttonsContainer.backgroundColor = UIColor.clear
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(buttonsContainer)
        
        buttonsContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        buttonsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonsContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        buttonsContainer.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6).isActive = true
        
        button1 = AnswerButton(answer: viewModel.currentTest().answers[0])
        guard let btn1 = button1 else { return }
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn1.addTarget(self, action: #selector(answerButtonClicked(button:)), for: .touchUpInside)
        buttonsContainer.addSubview(btn1)
        
        button2 = AnswerButton(answer: viewModel.currentTest().answers[1])
        guard let btn2 = button2 else { return }
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn2.addTarget(self, action: #selector(answerButtonClicked(button:)), for: .touchUpInside)
        buttonsContainer.addSubview(btn2)
        
        button3 = AnswerButton(answer: viewModel.currentTest().answers[2])
        guard let btn3 = button3 else { return }
        btn3.translatesAutoresizingMaskIntoConstraints = false
        btn3.addTarget(self, action: #selector(answerButtonClicked(button:)), for: .touchUpInside)
        buttonsContainer.addSubview(btn3)
        
        self.view.layoutIfNeeded()
        let padding = buttonsContainer.frame.size.height * 0.05
        
        btn2.centerXAnchor.constraint(equalTo: buttonsContainer.centerXAnchor).isActive = true
        btn2.centerYAnchor.constraint(equalTo: buttonsContainer.centerYAnchor).isActive = true
        btn2.widthAnchor.constraint(equalTo: buttonsContainer.widthAnchor, multiplier: 0.8).isActive = true
        btn2.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        btn1.centerXAnchor.constraint(equalTo: btn2.centerXAnchor).isActive = true
        btn1.widthAnchor.constraint(equalTo: btn2.widthAnchor).isActive = true
        btn1.heightAnchor.constraint(equalTo: btn2.heightAnchor).isActive = true
        btn1.bottomAnchor.constraint(equalTo: btn2.topAnchor, constant: -padding).isActive = true
        
        btn3.centerXAnchor.constraint(equalTo: btn2.centerXAnchor).isActive = true
        btn3.widthAnchor.constraint(equalTo: btn2.widthAnchor).isActive = true
        btn3.heightAnchor.constraint(equalTo: btn2.heightAnchor).isActive = true
        btn3.topAnchor.constraint(equalTo: btn2.bottomAnchor, constant: padding).isActive = true
    }
    
    func setSignImageView() {
        if signImageView != nil { return }
        
        signImageView = UIImageView(image: ImageManager.shared.load(image: viewModel.currentTest().sign.image))
        guard let iv = signImageView, let container = testContainerView, let buttonsContainer = buttonsContainer else { return }
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = UIColor.clear
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(imageContainer)
        
        imageContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageContainer.bottomAnchor.constraint(equalTo: buttonsContainer.topAnchor).isActive = true
        imageContainer.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        
        iv.backgroundColor = UIColor.clear
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(iv)
        
        iv.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
        iv.heightAnchor.constraint(equalTo: imageContainer.heightAnchor, multiplier: 0.5).isActive = true
        iv.widthAnchor.constraint(equalTo: imageContainer.heightAnchor).isActive = true
    }
    
    func changeButtons(enabled: Bool) {
        guard let btn1 = button1, let btn2 = button2, let btn3 = button3 else { return }
        btn1.isUserInteractionEnabled = enabled
        btn2.isUserInteractionEnabled = enabled
        btn3.isUserInteractionEnabled = enabled
    }
    
    func reloadUI(forTest test: TestModel) {
        guard let btn1 = button1, let btn2 = button2, let btn3 = button3, let iv = signImageView else { return }
        btn1.updateAnswer(answer: test.answers[0])
        btn2.updateAnswer(answer: test.answers[1])
        btn3.updateAnswer(answer: test.answers[2])
        iv.image = ImageManager.shared.load(image: test.sign.image)
    }
    
    func goNext() {
        if self.viewModel.isLastTest() {
            // Go to results screen
        }else {
            self.changeButtons(enabled: true)
            self.viewModel.goToNextTest()
            self.reloadUI(forTest: self.viewModel.currentTest())
        }
    }
    
    // MARK: - Actions
    
    @objc func answerButtonClicked(button: AnswerButton) {
        guard let btn1 = button1, let btn2 = button2, let btn3 = button3 else { return }
        let buttons = [btn1, btn2, btn3]
        changeButtons(enabled: false)
        if button.answer.title == viewModel.currentTest().correctAnswer() {
            button.change(answerType: .correct)
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Settings.correctAnswerHighlightDuration, execute: {
                self.goNext()
            })
        }else {
            button.change(answerType: .wrong)
            for btn in buttons {
                if btn.answer.title == viewModel.currentTest().correctAnswer() {
                    btn.highlightCorrectAnswer()
                    break
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Settings.delayBetweenTests, execute: {
                self.goNext()
            })
        }
        
    }
    
    
}
