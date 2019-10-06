//
//  CategoryCollectionViewCell.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/19/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var bgView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 15.0
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(bgView)
        bgView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        bgView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, constant: 0).isActive = true
        bgView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: 0).isActive = true
        
        bgView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor, constant: -(frame.size.height * 0.15)).isActive = true
        imageView.heightAnchor.constraint(equalTo: bgView.heightAnchor, multiplier: 0.5).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
        
        bgView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -5).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
