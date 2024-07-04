//
// MenuController.swift
// MacAProject
//
// Created by 머성이 on 7/3/24.
//
import UIKit
import SnapKit
import SwiftUI

//컬렉션뷰
class SBMenuController: UIViewController {
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
    
    
    // 오토레이아웃
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
}

extension SBMenuController: UICollectionViewDataSource, UICollectionViewDelegate {
    //컬렉션뷰 내 셀 항목(수량)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "img", for: indexPath) as! MenuView
        let menuItem = img[indexPath.item]
        cell.imgView.image = UIImage(named: menuItem.imageName)
        return cell
    }
}

extension SBMenuController: UICollectionViewDelegateFlowLayout {
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
#endif
