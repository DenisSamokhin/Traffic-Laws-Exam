//
//  CategoryViewController.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let cellId = "CategoryCellIdentifier"
    var viewModel: CategoriesViewModel
    
    private var collectionView: UICollectionView?
    
    // MARK: - Initialiation
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUI()
    }
    
    // MARK: - UI
    
    func setUI() {
        setCollectionView()
    }
    
    func setCollectionView() {
        // Proceed if collection view doesn't exist
        if collectionView != nil { return }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        guard let cv = collectionView, let view = self.view else { return }
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.additionalSafeAreaInsets.bottom, right: 0)
        self.view.addSubview(cv)
        
        // Register custom cell class
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        cv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        cv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        cv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    

}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? self.viewModel.categoriesTitles.count - 1 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.titleLabel.text = (indexPath.section == 1) ? viewModel.categoriesTitles.last : viewModel.categoriesTitles[indexPath.row]
        cell.imageView.image = UIImage(named: "test-sign-image")
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        let categoryId = (indexPath.section == 0) ? viewModel.getID(index: indexPath.row) : 0
        let exam = ExamManager.shared.createExam(categoryId: categoryId)
        let examVM = ExamViewModel(exam: exam)
        let examVC = ExamViewController(viewModel: examVM)
        self.present(examVC, animated: true, completion: nil)
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = self.view.frame.size.width / 2
        let itemHeight = itemWidth * 0.8
        return (indexPath.section == 1) ? CGSize(width: collectionView.frame.size.width, height: itemHeight) : CGSize(width: itemWidth, height: itemHeight)
    }
}
