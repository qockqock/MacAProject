//
// MenuController.swift
// MacAProject
//
// Created by 머성이 on 7/3/24.
//
import UIKit
import SnapKit
import SwiftUI


//음료 정보 텍스트를 담을 클래스
class CustomCollectionViewCell: UICollectionViewCell {
    let label: UILabel = {
        let drink = UILabel()
        drink.backgroundColor = .white
        drink.textColor = .black
        drink.textAlignment = .center
        drink.font = UIFont.systemFont(ofSize: 14)
        return drink
    }()
    
    //UICollectionViewCell의 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
//make.top.equalTo(SBMenuController.collectionView.snp.bottom).offset(5)
            make.top.equalToSuperview().offset(150)
            make.height.equalTo(20) // 텍스트 높이
            make.width.equalTo(110) // 텍스트 너비
        }
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("*T_T*")
    }
}

//컬렉션뷰
class SBMenuController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    // 이미지 배열
    let img = CoffeeList.smoothie_Menu
    
    
    //컬렉션뷰를 뷰에 추가하고 데이터소스 및 델리게이트를 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        //뷰 백그라운드컬러 안 정해주면 안됨!!!!!!!!!!!!!
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        // 셀 등록
        collectionView.register(MenuView.self, forCellWithReuseIdentifier: "img")
    }
    
    //컬렉션뷰 내 셀 항목(수량)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count // 예시 항목 개수
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! MenuView
        let menuItem = img[indexPath.item]
        cell.imgView.image = UIImage(named: menuItem.imageName)
        return cell
    }
    
    
    
    // UICollectionViewDelegateFlowLayout 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 130) // 텍스트 공간 포함 크기
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 80
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}


struct PreView: PreviewProvider {
 static var previews: some View {
   SBMenuController().toPreview()
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
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}


//struct PreView: PreviewProvider {
//    static var previews: some View {
//        SBMenuController().toPreview()
//    }
//}
//#if DEBUG
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//    func toPreview() -> some View {
//        Preview(viewController: self)
//    }
//}
//#endif
