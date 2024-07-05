//
//  OrderSheetController.swift
//  MacAProject
//
//  Created by ahnzihyeon on 7/4/24.
//

import UIKit
import SwiftUI
import SnapKit
//MARK: - OrderSheetController 클래스: 주문 내역 버튼을 관리하는 클래스
class OrderSheetController: UIViewController {
    //tvc 클래스 변수로 변환
    let tvc = TableViewController()
    
    let orderListButton = UIButton()
    
    var showModal = false
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentButton_Home()
        addNotiObserver()
        
    }
    // 홈에 있는 주문하기 버튼
    func paymentButton_Home() {
        
        print("called - PaymentButton")
        // 버튼의 타이틀, 색상, 배경색, 폰트 설정
        orderListButton.setTitle("주문 내역", for: .normal)
        orderListButton.setTitleColor(.white, for: .normal)
        orderListButton.backgroundColor = #colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1)
        orderListButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        orderListButton.layer.cornerRadius = 15
        
        // 버튼을 뷰에 추가하고 오토레이아웃 설정
        self.view.addSubview(orderListButton)
        orderListButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(65)
            $0.width.equalTo(350)
            $0.centerX.equalToSuperview()
        }
        
        // 버튼 클릭 시 ShowOderList 메서드를 호출하도록 설정
        orderListButton.addTarget(self, action: #selector(ShowOderList), for: .touchDown)
    }
    private func addNotiObserver() {
        NotificationCenter.default.addObserver(self,selector:#selector(showOrderButton(_:)), name: NSNotification.Name("notiData"),object: nil)
    }
    
    //버튼 숨기기 에니메이션
    func hideOrderButton() {
        UIView.animate(withDuration: 0.5) {
            // 버튼을 화면 아래로 이동
            self.orderListButton.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(-80) // 화면 바깥으로 이동
            }
            self.view.layoutIfNeeded() // 제약 조건 업데이트
        }
    }
    // 버튼 제자리 에니메이션
    
    @objc 
    func showOrderButton(_ notification: Notification) {
        
        if let showModal = notification.userInfo?["showModal"] as? Bool {
            self.showModal = showModal
            print("showModal: \(showModal)")
        }
            UIView.animate(withDuration: 0.5) {
                // 버튼을 초기 위치로 되돌림
                self.orderListButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview().inset(30) // 초기 위치로 되돌림
                }
                self.view.layoutIfNeeded() // 제약 조건 업데이트
            }
    }
    
    
    //MARK: - 주문 내역 모달을 표시하는 메서드
    @objc
    func ShowOderList() {
        //MARK: - 모달 생성, 설정
        if let orderSheet = tvc.sheetPresentationController {
            orderSheet.detents = [.medium()]
            orderSheet.preferredCornerRadius = 20
            orderSheet.prefersGrabberVisible = true
        }
        self.present(tvc, animated: true)
        hideOrderButton()
    }
    
    //MARK: - 토스트 알림
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

//// SwiftUI 미리보기 설정
//struct PreView2: PreviewProvider {
//    static var previews: some View {
//        OrderSheetController().toPreview()
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
//    func toPreview2() -> some View {
//        Preview(viewController: self)
//    }
//}
//#endif
