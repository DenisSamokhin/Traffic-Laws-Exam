//
//  ResultViewController.swift
//  Traffic Laws Exam
//
//  Created by Denis on 9/4/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var viewModel: ResultViewModel
    weak var coordinator: MainCoordinator?
    
    var middleContainerView: UIView?
    var bottomContainerView: UIView?
    var resultLabel: UILabel?
    var homeButton: DefaultButton?
    var repeatButton: DefaultButton?
    
    // MARK: - Initialiation
    
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        self.viewModel.saveExam()
        setUI()
    }
    
    // MARK: - UI
    
    func setUI() {
        setMiddleContainerView()
        setBottomContainerView()
        setResultLabel()
        setHomeButton()
        setRepeatButton()
    }
    
    func setMiddleContainerView() {
        
        if middleContainerView != nil { return }
        
        middleContainerView = UIView()
        guard let container = middleContainerView else { return }
        container.backgroundColor = UIColor.orange
        container.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(container)
        
        container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
        container.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func setBottomContainerView() {
        
        if bottomContainerView != nil { return }
        
        bottomContainerView = UIView()
        guard let container = bottomContainerView, let middleContainerView = middleContainerView else { return }
        container.backgroundColor = UIColor.orange
        container.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(container)
        
        container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        container.topAnchor.constraint(equalTo: middleContainerView.bottomAnchor, constant: 0).isActive = true
    }

    func setResultLabel() {
        
        resultLabel = UILabel()
        guard let label = resultLabel, let container = middleContainerView else { return }
        
        label.textAlignment = .center
        label.text = viewModel.currentScoreString()
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 0).isActive = true
        
    }
    
    func setHomeButton() {
        homeButton = DefaultButton(title: "На главную")
        guard let btn1 = homeButton, let container = bottomContainerView else { return }
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn1.addTarget(self, action: #selector(homeButtonClicked), for: .touchUpInside)
        container.addSubview(btn1)
        
        btn1.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        btn1.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -40).isActive = true
        btn1.widthAnchor.constraint(equalToConstant: 180).isActive = true
        btn1.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func setRepeatButton() {
        repeatButton = DefaultButton(title: "Повторить тест")
        guard let btn1 = repeatButton, let btn2 = homeButton, let container = bottomContainerView else { return }
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn1.addTarget(self, action: #selector(repeatButtonClicked), for: .touchUpInside)
        container.addSubview(btn1)
        
        btn1.centerXAnchor.constraint(equalTo: btn2.centerXAnchor).isActive = true
        btn1.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 40).isActive = true
        btn1.widthAnchor.constraint(equalTo: btn2.widthAnchor).isActive = true
        btn1.heightAnchor.constraint(equalTo: btn2.heightAnchor).isActive = true
    }
    
    
    // MARK: - Actions
    
    @objc func homeButtonClicked() {
        guard let coordinator = coordinator else { return }
        coordinator.goToInitialScreen()
    }
    
    @objc func repeatButtonClicked() {
        guard let coordinator = coordinator else { return }
        coordinator.goToExamScreen(categoryId: viewModel.currentExam.categoryId)
    }

}
