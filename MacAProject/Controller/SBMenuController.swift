//
// MenuController.swift
// MacAProject
//
// Created by 머성이 on 7/3/24.
//


import UIKit
import SnapKit
import SwiftUI

protocol SBMenuCollectionViewCellDelegate: AnyObject {
    func didSelectCountButton(_ cell: CoffeeList)
}

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
        moveUnderline(to: 0)
        
        khMenuView.collectionView.dataSource = self
        khMenuView.collectionView.delegate = self
        
        khMenuView.segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        currentCategoryIndex = sender.selectedSegmentIndex
        khMenuView.collectionView.reloadData()
        moveUnderline(to: sender.selectedSegmentIndex)
    }
    
    // 밑줄 이동 메서드
    private func moveUnderline(to index: Int) {
        let segmentWidth = khMenuView.segmentControl.frame.width / CGFloat(khMenuView.segmentControl.numberOfSegments)
        let leadingConstraint = segmentWidth * CGFloat(index) + 10 // 10은 여유로운 여백
        UIView.animate(withDuration: 0.3) {
            self.khMenuView.underlineView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(leadingConstraint)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    // priceLabel Text에 , 추가하는 메서드
    private func formatPrice(_ price: String) -> String? {
        guard let priceNumber = Double(price) else { return price }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: priceNumber))
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
        cell.beverageLabel.text = menuItem.menuName.replacingOccurrences(of: " ", with: "\n")
//        cell.beverageLabel.text = "\(menuItem.menuName)"
        if let formattedPrice = formatPrice(menuItem.menuPrice) {
            cell.priceLabel.text = "\(formattedPrice)원"
        } else {
            cell.priceLabel.text = "\(menuItem.menuPrice)원"
        }
//        cell.priceLabel.text = "\(menuItem.menuPrice)원"
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
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 좌 우 간격
        return 0
    }
}
