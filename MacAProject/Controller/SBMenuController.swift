//
// MenuController.swift
// MacAProject
//
// Created by 머성이 on 7/3/24.
//


import UIKit
import SnapKit

class SBMenuController: UIViewController {
    
    // 카테고리 메뉴 배열
    var menus: [[CoffeeList]] = [
        CoffeeList.allArray,
        CoffeeList.recommended_Menu,
        CoffeeList.coffee_Menu,
        CoffeeList.beverage_Menu,
        CoffeeList.dessert_Menu,
        CoffeeList.do_not_eat_Menu
    ]
    
    // 현재 선택된 카테고리 인덱스
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
        khMenuView.collectionView.register(SBMenuCell.self, forCellWithReuseIdentifier: "img")
        
        khMenuView.segmentControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }

    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        currentCategoryIndex = sender.selectedSegmentIndex
        khMenuView.collectionView.reloadData()
        moveUnderline(to: sender.selectedSegmentIndex)
    }
    
    // 밑줄 이동 메서드
    private func moveUnderline(to index: Int) {
        khMenuView.moveUnderline(to: index)
    }
    
    // priceLabel Text에 , 추가하는 메서드
    private func formatPrice(_ price: String) -> String? {
//        guard let priceNumber = Double(price) else { return price }
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        return numberFormatter.string(from: NSNumber(value: priceNumber))
        guard let priceNumber = Int(price) else { return price }
        return priceNumber.numberFormat()
    }
}

extension SBMenuController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus[currentCategoryIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! SBMenuCell
        let menuItem = menus[currentCategoryIndex][indexPath.item]
        cell.imgView.image = UIImage(named: menuItem.imageName)
        cell.beverageLabel.text = menuItem.menuName.replacingOccurrences(of: " ", with: "\n")
        //        cell.beverageLabel.text = "\(menuItem.menuName)"
        if let formattedPrice = formatPrice(menuItem.menuPrice) {
            cell.priceLabel.text = "\(formattedPrice)원"
        } else {
            cell.priceLabel.text = "\(menuItem.menuPrice)원"
        }
        cell.imageTapAction = {
            print("called: SBMenu - \(menuItem)")
        }
        return cell
    }
    
    // cell이 클릭 됐을때 동작함
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let menuItem = menus[currentCategoryIndex][indexPath.item]
//        let orderVC = TableViewController()
//        orderVC.menuItem = menuItem
//        orderVC.addOrder(imageName: menuItem.imageName, menuName: menuItem.menuName, menuPrice: menuItem.menuPrice)
        let menuItem = menus[currentCategoryIndex][indexPath.item]
        Basket.stc.addItem(menuItem)
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

