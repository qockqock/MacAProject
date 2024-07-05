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
    
    // 컬렉션 뷰 생성
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 100
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    // 카테고리 종류 생성
    let categories = ["추천메뉴", "커피", "디저트", "스무디", "티", "왜먹어?"]
    
    // 카테고리 메뉴 배열
    var drinks: [[CoffeeList]] = [CoffeeList.recommended_Menu, CoffeeList.coffee_Menu, CoffeeList.dessert_Menu, CoffeeList.smoothie_Menu, CoffeeList.tea_Menu, CoffeeList.do_not_eat_Menu]
    
    var currentCategoryIndex: Int = 0
    
    // 로고 이미지 설정
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    // 세그먼트 컨트롤 생성
    lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: categories)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        control.backgroundColor = .white
        control.tintColor = .white
        control.selectedSegmentTintColor = .clear
        control.apportionsSegmentWidthsByContent = true
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        control.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupLayout()
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        [logoImageView, segmentControl, collectionView].forEach {
            view.addSubview($0)
        }
        
        //Logo Constraints
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-10) //솔비 offset 값 변경
            $0.centerX.equalToSuperview()
            $0.width.equalTo(255) //솔비 변경
            $0.height.equalTo(100)
        }
        
        //카테고리 Constraints
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(5) //솔비 offset 값 변경
            $0.left.right.equalToSuperview().inset(20)
        }
        
        //컬렉션뷰(메뉴 리스트) Constraints
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20))
        }
        collectionView.register(MenuView.self, forCellWithReuseIdentifier: "img")
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        currentCategoryIndex = sender.selectedSegmentIndex
        collectionView.reloadData()
    }
}

extension SBMenuController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks[currentCategoryIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! MenuView
        let menuItem = drinks[currentCategoryIndex][indexPath.item]
        cell.imgView.image = UIImage(named: menuItem.imageName)
        cell.beverageLabel.text = "\(menuItem.menuName)"
        cell.priceLabel.text = "\(menuItem.menuPrice)"
        return cell
    }
}

extension SBMenuController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //셀 크기 조정
        return CGSize(width: 117, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //셀 위 아래 간격
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //셀 좌 우 간격
        return 0
    }
}


struct PreView123: PreviewProvider {
    static var previews: some View {
        ViewController().toPreview123()
    }
}

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    func toPreview123() -> some View {
        Preview(viewController: self)
    }
}
#endif
