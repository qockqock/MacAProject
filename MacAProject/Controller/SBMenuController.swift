//
// MenuController.swift
// MacAProject
//
// Created by 머성이 on 7/3/24.
//


import UIKit
import SnapKit
import SwiftUI

class SBMenuController: UIViewController {
    
    // 카테고리 메뉴 배열
    var drinks: [[CoffeeList]] = [CoffeeList.recommended_Menu, CoffeeList.coffee_Menu, CoffeeList.dessert_Menu, CoffeeList.smoothie_Menu, CoffeeList.tea_Menu, CoffeeList.do_not_eat_Menu]
    
    var currentCategoryIndex: Int = 0
    
    // khMenuView = 로고, 카테고리 관련
    private let khMenuView = KHMenuView()
    
    override func loadView() {
        view = khMenuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        khMenuView.collectionView.dataSource = self
        khMenuView.collectionView.delegate = self
        
        khMenuView.segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        currentCategoryIndex = sender.selectedSegmentIndex
        khMenuView.collectionView.reloadData()
    }
}

extension SBMenuController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks[currentCategoryIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! SBMenuCell
        let menuItem = drinks[currentCategoryIndex][indexPath.item]
        cell.imgView.image = UIImage(named: menuItem.imageName)
        cell.beverageLabel.text = "\(menuItem.menuName)"
        cell.priceLabel.text = "\(menuItem.menuPrice)"
        return cell
    }
}

extension SBMenuController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기 조정
        return CGSize(width: 117, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 위 아래 간격
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 좌 우 간격
        return 0
    }
}
