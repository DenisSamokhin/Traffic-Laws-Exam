//
//  CategoryViewController.swift
//  Traffic Laws Exam
//
//  Created by Denis on 8/13/19.
//  Copyright © 2019 ITLions. All rights reserved.
//

import UIKit
import ViewAnimator

class CategoryViewController: UIViewController {
    
    let cellId = "CategoryCellIdentifier"
    var viewModel: CategoriesViewModel
    weak var coordinator: MainCoordinator?
    var bgImageView: UIImageView?
    let cellPadding: CGFloat = 10.0
    
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
        self.view.backgroundColor = Constants.Colors.violet
        setUI()
        self.animate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: - UI
    
    func setUI() {
        //setBgImageView()
        setCollectionView()
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
    
    func setCollectionView() {
        // Proceed if collection view doesn't exist
        if collectionView != nil { return }
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = cellPadding * 2;
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
    
    private func twoSectionMode() -> Bool {
        return self.viewModel.categoriesTitles.count % 2 != 0
    }
    
    func animate() {
        let zoomAnimation = AnimationType.zoom(scale: 0.01)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
        guard let cv = collectionView else { return }
        cv.reloadData()
        cv.performBatchUpdates({
            UIView.animate(views: cv.orderedVisibleCells,
                           animations: [rotateAnimation, zoomAnimation], animationInterval: 0.2, duration: 0.8, completion: {
                })
        }, completion: nil)
    }

}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (twoSectionMode()) ? ((section == 0) ? self.viewModel.categoriesTitles.count - 1 : 1) : self.viewModel.categoriesTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.titleLabel.text = (twoSectionMode()) ? ((indexPath.section == 1) ? viewModel.categoriesTitles.last : viewModel.categoriesTitles[indexPath.row]) : viewModel.categoriesTitles[indexPath.row]
        
        if let imgName = (twoSectionMode()) ? ((indexPath.section == 1) ? viewModel.categoriesImages.last : viewModel.categoriesImages[indexPath.row]) : viewModel.categoriesImages[indexPath.row], imgName != "" {
            cell.imageView.image = ImageManager.shared.load(image: imgName)
        }else {
            cell.imageView.image = UIImage(named: Constants.ImageNames.categoriesPlaceholderImage)
        }
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (twoSectionMode()) ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        let categoryId = (twoSectionMode()) ? ((indexPath.section == 0) ? viewModel.getID(index: indexPath.row) : 0) : ((indexPath.row == viewModel.categoriesTitles.count - 1) ? 0 : viewModel.getID(index: indexPath.row))
        guard let coordinator = coordinator else { return }
        coordinator.goToExamScreen(categoryId: categoryId)
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = self.view.frame.size.width / 2 - cellPadding * 2
        let itemHeight = itemWidth * 0.8
        return (twoSectionMode()) ? ((indexPath.section == 1) ? CGSize(width: collectionView.frame.size.width, height: itemHeight) : CGSize(width: itemWidth, height: itemHeight)) : CGSize(width: itemWidth, height: itemHeight)
    }
}
