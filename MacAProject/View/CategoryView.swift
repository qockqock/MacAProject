// 카테고리

import UIKit
import SnapKit

protocol CoffeeListViewDelegate: AnyObject {
    func segmentValueChanged(to index: Int)
    func configureCollectionViewConstraints()
    func configureCollectionViewAppearance()
}

class CategoryView: UIView {
    
    weak var delegate: CoffeeListViewDelegate?
    
    let categories = ["추천메뉴", "커피", "디저트", "스무디", "티", "비추천메뉴"]
    
    var drinks: [[CoffeeList]] = [] // 컬렉션 뷰 데이터를 담을 배열
    
    lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: categories)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = .white
        control.tintColor = .white
        control.selectedSegmentTintColor = .clear
        control.apportionsSegmentWidthsByContent = true // 텍스트 길이에 맞게 너비 조절
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14) // 글자 크기를 축소하여 모든 텍스트가 보이도록 설정
        ]
        control.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14) // 선택된 상태의 글자 크기도 축소
        ]
        control.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        return control
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupLogo()
        setupSegmentControl()
        setupCollectionView()
        
        drinks = [CoffeeList.recommended_Menu, CoffeeList.coffee_Menu, CoffeeList.dessert_Menu, CoffeeList.smoothie_Menu, CoffeeList.tea_Menu, CoffeeList.do_not_eat_Menu]
        
        collectionView.reloadData()
    }
    
    private func setupLogo() {
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    
    private func setupSegmentControl() {
        addSubview(segmentControl)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        
        
        
        delegate?.configureCollectionViewConstraints()
    }
    
    @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentValueChanged(to: sender.selectedSegmentIndex)
    }
}

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks[segmentControl.selectedSegmentIndex].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let coffee = drinks[segmentControl.selectedSegmentIndex][indexPath.item]
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: coffee.imageName)
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        let label = UILabel()
        label.text = "\(coffee.menuName) - \(coffee.menuPrice)원"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail // Truncate tail for long text
        label.font = UIFont.systemFont(ofSize: 14) // 글자 크기 축소
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(5)
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        
        return cell
    }
}

extension CategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
