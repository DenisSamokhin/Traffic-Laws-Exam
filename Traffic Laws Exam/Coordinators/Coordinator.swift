//
//  Coordinator.swift
//  Traffic Laws Exam
//
//  Created by Denis on 9/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
