//
//  ViewController.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/12/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let examButton = DefaultButton(title: "Начать тест")
    let profileButton = DefaultButton(title: "Мои результаты")
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        setUI()
    }
    
    // MARK: - UI
    
    func setUI() {
        setupExamButton()
        setupProfileButton()
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

    // MARK: - Navigation
    
    @objc func goToCategoryVC() {
        guard let coordinator = coordinator else { return }
        coordinator.goToCategoriesScreen()
    }
    
    @objc func goToProfile() {
        let exams = DataManager.shared.getStoredExams()
        exams.forEach({
            print($0.datePassed)
            
        })
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

