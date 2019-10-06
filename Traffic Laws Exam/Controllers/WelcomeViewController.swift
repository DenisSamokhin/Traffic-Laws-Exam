//
//  ViewController.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/12/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit
import ViewAnimator

class WelcomeViewController: UIViewController {
    
    let examButton = DefaultButton(title: "Начать тест")
    let profileButton = DefaultButton(title: "Мои результаты")
    var bgImageView: UIImageView?
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        setUI()
        animate()
    }
    
    // MARK: - UI
    
    func setUI() {
        setBgImageView()
        setupExamButton()
        setupProfileButton()
    }
    
    func setBgImageView() {
        if bgImageView != nil { return }
        
        guard let img = UIImage(named: Constants.ImageNames.bgImage) else { return }
        let iv = UIImageView(image: img)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(iv)
        
        iv.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        iv.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        iv.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        iv.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        bgImageView = iv
    }
    
    func setupExamButton() {
        examButton.translatesAutoresizingMaskIntoConstraints = false
        examButton.addTarget(self, action: #selector(goToCategoryVC), for: .touchUpInside)
        self.view.addSubview(examButton)
        
        examButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        examButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        examButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        examButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setupProfileButton() {
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        self.view.addSubview(profileButton)
        
        profileButton.centerXAnchor.constraint(equalTo: examButton.centerXAnchor).isActive = true
        profileButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 40).isActive = true
        profileButton.widthAnchor.constraint(equalTo: examButton.widthAnchor).isActive = true
        profileButton.heightAnchor.constraint(equalTo: examButton.heightAnchor).isActive = true
    }
    
    func animate() {
        let fromRightAnimation = AnimationType.from(direction: .right, offset: 300.0)

        UIView.animate(views: [examButton], animations: [fromRightAnimation], duration: 0.8)
        UIView.animate(views: [profileButton], animations: [fromRightAnimation], delay: 0.4, duration: 0.8)
    }

    // MARK: - Navigation
    
    @objc func goToCategoryVC() {
        guard let coordinator = coordinator else { return }
        coordinator.goToCategoriesScreen()
    }
    
    @objc func goToProfile() {
        let exams = DataManager.shared.getStoredExams()
        for exam in exams {
            print(exam.datePassed)
            exam.tests.forEach({
                print("--Correct: " + $0.correctAnswer)
                print("--Selected: " + ($0.selectedAnswer ?? ""))
            })
        }
    }
    
    // MARK: -
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Why are you shaking me?")
            UIDevice.vibrate()
            guard let coordinator = coordinator else { return }
            coordinator.goToExamScreen(categoryId: 1)
        }
    }
    
}

