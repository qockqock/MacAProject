//
//  MenuView.swift
//  MacAProject
//
//  Created by 머성이 on 7/4/24.
//

import UIKit
import SnapKit

protocol KHMenuViewDelegate: AnyObject {
    func segmentValueChanged(to index: Int)
}

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
        view.translatesAutoresizingMaskIntoConstraints = false
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
    let categories = ["추천메뉴", "커피", "디저트", "스무디", "티", "왜먹어?"]
    
    weak var delegate: KHMenuViewDelegate?
    
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
            $0.top.equalTo(segmentControl.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20))
        }
        collectionView.register(SBMenuCell.self, forCellWithReuseIdentifier: "img")
    }
}

// MARK: - SBMenuCell : 컬렉션 뷰의 셀을 담당
class SBMenuCell: UICollectionViewCell {
    let imgView = UIImageView()
    let beverageLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imgView)
        contentView.addSubview(beverageLabel)
        contentView.addSubview(priceLabel)
        
        imgView.contentMode = .scaleAspectFit
        
        imgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.width)
        }
        
        beverageLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(beverageLabel.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

