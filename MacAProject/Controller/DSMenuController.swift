//
// MenuController.swift
// MacAProject
//
// Created by 머성이 on 7/3/24.
//

import UIKit
import SnapKit
import SwiftUI

class Menu: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 컬렉션 뷰를 서브뷰로 추가
        view.addSubview(collectionView)
        // 컬렉션 뷰의 데이터 소스와 델리게이트 설정
        collectionView.dataSource = self
        collectionView.delegate = self
        // 컬렉션 뷰 구성 설정
        configureCollectionView()
    }
    func configureCollectionView() {
        // SnapKit을 사용하여 컬렉션 뷰의 레이아웃 설정
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // 셀 등록
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    // UICollectionViewDataSource 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 // 예시 항목 개수
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    // UICollectionViewDelegateFlowLayout 메서드
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100) // 예시 항목 크기
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // 예시 줄 간격
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // 예시 항목 간격
    }
}

struct PreView: PreviewProvider {
    static var previews: some View {
        Menu().toPreview()
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
