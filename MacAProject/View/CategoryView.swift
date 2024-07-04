// 카테고리

import UIKit
import SnapKit

protocol CoffeeListViewDelegate: AnyObject {
    func segmentValueChanged(to index: Int)
}

class CategoryView: UIView {
    
    weak var delegate: CoffeeListViewDelegate?
    
    private let categories = ["추천메뉴", "커피", "디저트", "스무디", "티", "비추천메뉴"]
    
    // 컬렉션 뷰 데이터를 담을 배열
    var drinks: [[CoffeeList]] = []
    
    // 세그먼트 컨트롤 관련 세부설정
    lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: categories)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        control.backgroundColor = .white
        control.tintColor = .white
        control.selectedSegmentTintColor = .clear
        control.apportionsSegmentWidthsByContent = true
        
        // 폰트 설정
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
    
    // 로고 이미지 뷰 생성
    lazy var logoImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "logo")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰 설정 함수
    private func setupViews() {
        addSubview(logoImageView)
//        addSubview(segmentControl)
        
        // 세그먼트 컨트롤 관련 카테고리
//        drinks = [CoffeeList.recommended_Menu, CoffeeList.coffee_Menu, CoffeeList.dessert_Menu, CoffeeList.smoothie_Menu, CoffeeList.tea_Menu, CoffeeList.do_not_eat_Menu]
        
//        setupLayout()
    }
    
//    private func setupLayout() {
//        logoImageView.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(100)
//        }
//        
//        segmentControl.snp.makeConstraints { make in
//            make.top.equalTo(logoImageView.snp.bottom).offset(20)
//            make.left.right.equalToSuperview().inset(20)
//        }
//    }
    
    // 세그먼트 컨트롤 값 변경 시 호출되는 함수
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentValueChanged(to: sender.selectedSegmentIndex)
    }
}
