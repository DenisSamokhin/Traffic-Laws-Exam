//
//  MainCoordinator.swift
//  Traffic Laws Exam
//
//  Created by Denis on 9/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = WelcomeViewController.init()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func goToCategoriesScreen() {
        let categoryViewModel = CategoriesViewModel(models: DataManager.shared.getCategoriesList())
        let categoryVC = CategoryViewController(viewModel: categoryViewModel)
        categoryVC.coordinator = self
        self.navigationController.pushViewController(categoryVC, animated: true)
    }
    
    func goToExamScreen(categoryId: Int) {
        let exam = ExamManager.shared.createExam(categoryId: categoryId)
        let examVM = ExamViewModel(exam: exam)
        let examVC = ExamViewController(viewModel: examVM)
        examVC.coordinator = self
        self.navigationController.pushViewController(examVC, animated: true)
    }
    
    func goToResultsScreen(exam: ExamModel, score: Int) {
        let resultViewModel = ResultViewModel(exam: exam, score: score)
        let resultVC = ResultViewController(viewModel: resultViewModel)
        resultVC.coordinator = self
        self.navigationController.pushViewController(resultVC, animated: true)
    }
    
    func goToPreviousScreen() {
        self.navigationController.popViewController(animated: true)
    }
    
    func goToInitialScreen() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
