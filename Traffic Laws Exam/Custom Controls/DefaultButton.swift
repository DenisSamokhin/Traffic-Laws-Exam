//
//  DefaultButton.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/12/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {
    
    var cornerRadius: CGFloat

    init(_ cornerRadius: CGFloat = 5.0, title: String) {
        self.cornerRadius = cornerRadius
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setupDefaultUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDefaultUI() {
        self.backgroundColor = ButtonSettings.Colors.DefaultButton.bgColor
        self.setTitleColor(ButtonSettings.Colors.DefaultButton.textColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
    }
}
