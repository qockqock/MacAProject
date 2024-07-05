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
    var drinks: [[CoffeeList]] = [
        CoffeeList.recommended_Menu,
        CoffeeList.coffee_Menu,
        CoffeeList.dessert_Menu,
        CoffeeList.smoothie_Menu,
        CoffeeList.tea_Menu,
        CoffeeList.do_not_eat_Menu
    ]
    
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
        
        return control
    }()
    
    // 선택된 세그먼트의 밑줄 View
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupLayout()
        moveUnderline(to: 0) // 초기 위치로 밑줄 이동
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        [logoImageView, segmentControl, collectionView, underlineView].forEach {
            view.addSubview($0)
        }
        
        // Logo Constraints
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(255)
            $0.height.equalTo(100)
        }
        
        // 세그먼트 Constraints
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(5)
            $0.width.equalToSuperview()
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        // 밑줄 Constraints
        underlineView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.leading.equalToSuperview().offset(10) // 초기 위치
            $0.bottom.equalTo(segmentControl.snp.bottom).offset(2) // 세그먼트 아래에 위치
            $0.width.equalTo(segmentControl.snp.width).dividedBy(CGFloat(categories.count))
        }
        
        // 컬렉션뷰(메뉴 리스트) Constraints
        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20))
        }
        collectionView.register(MenuView.self, forCellWithReuseIdentifier: "img")
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        currentCategoryIndex = sender.selectedSegmentIndex
        collectionView.reloadData()
        moveUnderline(to: sender.selectedSegmentIndex)
    }
    
    // 밑줄 이동 메서드
    private func moveUnderline(to index: Int) {
        let segmentWidth = segmentControl.frame.width / CGFloat(categories.count)
        let leadingConstraint = segmentWidth * CGFloat(index) + 10 // 10은 여유로운 여백
        
        UIView.animate(withDuration: 0.3) {
            self.underlineView.snp.updateConstraints {
                $0.leading.equalToSuperview().offset(leadingConstraint)
            }
            self.view.layoutIfNeeded()
        }
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
        return CGSize(width: 117, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
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
