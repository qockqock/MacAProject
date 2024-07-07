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
    func showToast() {
          let toastLabel = UILabel()
          toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
          toastLabel.textColor = UIColor.white
          toastLabel.font = UIFont.systemFont(ofSize: 17.0)
          toastLabel.textAlignment = .center
          toastLabel.text = "장바구니에 메뉴를 추가했습니다"
          toastLabel.alpha = 1.0
          toastLabel.layer.cornerRadius = 7
          toastLabel.clipsToBounds  =  true

          self.view.addSubview(toastLabel)
          
          UIView.animate(withDuration: 0.9, delay: 0.6, options: .curveEaseOut, animations: {
              toastLabel.alpha = 0.0
          }, completion: {(isCompleted) in
              toastLabel.removeFromSuperview()
          })
          
          toastLabel.snp.makeConstraints {
              $0.center.equalToSuperview()
              $0.width.equalTo(280)
              $0.height.equalTo(50)
          }
      }
}
extension SBMenuController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = menus[currentCategoryIndex].count
        
        // 0인지 확인 (예외처리) - 대성
        khMenuView.updateEmptyState(isEmpty: itemCount == 0)
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! SBMenuCell
        
//        // 0인지 확인 (예외처리) - 대성
//        guard menus[currentCategoryIndex].indices.contains(indexPath.item) else {
//            return cell// 아무것도 하지 않음
//        }
        
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
        let menuItem = menus[currentCategoryIndex][indexPath.item]
        Basket.stc.addItem(menuItem)
        showToast()
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

