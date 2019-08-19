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
    }
    

}
