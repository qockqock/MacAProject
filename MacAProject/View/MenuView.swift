//
//  MenuView.swift
//  MacAProject
//
//  Created by 머성이 on 7/4/24.
//

import UIKit
import SnapKit

// MARK: - KHMenuView : 로고, 세그먼트 컨트롤 & 커스텀 관련, 컬렉션 뷰 관련 내용
class KHMenuView: UIView {
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
        control.backgroundColor = .white
        control.tintColor = .white
        control.selectedSegmentTintColor = .clear
        control.apportionsSegmentWidthsByContent = true
        
        // 카테고리 세그먼트 배경 하얗게
        control.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        control.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16)
        ]
        control.setTitleTextAttributes(normalTextAttributes, for: .normal)
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        control.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        return control
    }()
    
    // 선택된 세그먼트의 밑줄 View
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    // 컬렉션 뷰 생성
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 100
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    // 카테고리 종류 생성
    let categories = ["전체", "추천메뉴", "커피", "음료", "디저트", "왜먹어?"]
    
    weak var delegate: KHMenuViewDelegate?
    
    let orderView = OrderSheetController().view
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentValueChanged(to: sender.selectedSegmentIndex)
    }
    
    // 밑줄 이동 메서드
    func moveUnderline(to index: Int) {
        let segmentWidth = segmentControl.frame.width / CGFloat(categories.count)
        let leadingConstraint = segmentWidth * CGFloat(index)
        UIView.animate(withDuration: 0.3) {
            self.underlineView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(leadingConstraint)
            }
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [logoImageView, segmentControl, collectionView, underlineView].forEach {
            addSubview($0)
        }
        
        // 로고 Constraints
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(255)
            $0.height.equalTo(100)
        }
        
        // 카테고리 Constraints
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(5)
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        // 밑줄 Constraints
        underlineView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.width.equalTo(segmentControl.snp.width).dividedBy(categories.count)
            $0.height.equalTo(2)
            $0.leading.equalToSuperview()
        }
        
        // 컬렉션뷰(메뉴 리스트) Constraints
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
            $0.height.equalTo(500)
        }
        
        // orderView Constraints - 마지막에 추가
        //        orderView!.snp.makeConstraints {
        //            $0.bottom.equalToSuperview().inset(20)
        //            $0.centerX.equalToSuperview()
        //        }
        
        collectionView.register(SBMenuCell.self, forCellWithReuseIdentifier: "img")
        
        // 사용자 상호작용 가능 설정
        orderView!.isUserInteractionEnabled = true
    }
}

// MARK: - SBMenuCell : 컬렉션 뷰의 셀을 담당, 이미지 탭 기능
class SBMenuCell: UICollectionViewCell {
    var coffeeList: CoffeeList? {
        didSet {
            guard let coffee = coffeeList else { return }
            imgView.image = UIImage(named: coffee.imageName)
            beverageLabel.text = coffee.menuName
            priceLabel.text = Int(coffee.menuPrice)!.numberFormat()
        }
    }
    
    let imgView = UIImageView()
    
    // 음료이름 레이블 생성
    let beverageLabel = {
        let bl = UILabel()
        bl.textAlignment = .center
        bl.textColor = .black
        bl.backgroundColor = .white
        bl.clipsToBounds = true
        bl.numberOfLines = 2
        bl.font = UIFont.systemFont(ofSize: 15)
        return bl
    }()
    
    // 가격 레이블 생성
    let priceLabel = {
        let pl = UILabel()
        pl.textAlignment = .center
        pl.backgroundColor = .white
        pl.textColor = .black
        pl.clipsToBounds = true
//        pl.numberOfLines = 0
        pl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return pl
    }()
    
    var imageTapAction: (() -> Void)? // 이미지 클릭 액션 클로저
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        [imgView, beverageLabel, priceLabel].forEach {
            self.addSubview($0)
        }
        
        // 간격 맞추는 코드
        imgView.contentMode = .scaleAspectFit
        
        imgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.6)
        }
        
        beverageLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(0)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        priceLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped() {
        imageTapAction?() // 이미지 클릭 시 클로저 호출
    }
}

extension Int {
    func numberFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
