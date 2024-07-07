//
//  OrderSheetController.swift
//  MacAProject
//
//  Created by ahnzihyeon on 7/4/24.
//

import UIKit
import SnapKit

//MARK: - OrderSheetController 클래스: 주문 내역 버튼을 관리하는 클래스
class OrderSheetController: UIViewController {
    //tvc 클래스 변수로 변환
    private let basketViewController = BasketViewController()
    let tvc = BasketViewController()
    let orderListButton = UIButton()
    
    var showModal = false
    
    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentButton_Home()
        addNotiObserver()
    }
    
    // 홈에 있는 주문상품 버튼
    func paymentButton_Home() {
        print("called - PaymentButton")
        // 버튼의 타이틀, 색상, 배경색, 폰트 설정
        orderListButton.setTitle("주문 상품", for: .normal)
        orderListButton.setTitleColor(.white, for: .normal)
        orderListButton.backgroundColor = #colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1)
        orderListButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        orderListButton.layer.cornerRadius = 10
        
        // 버튼을 뷰에 추가하고 오토레이아웃 설정
        self.view.addSubview(orderListButton)
        orderListButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(58)
            $0.width.equalTo(350)
            $0.centerX.equalToSuperview()
        }
        
        // 버튼 클릭 시 모달 창 띄우기
        orderListButton.addTarget(self, action: #selector(showOrderListModal), for: .touchDown)
    }
    
    // 대성 추가
    @objc func showBasket() {
        present(tvc, animated: true, completion: nil)
    }
    
    // 알림 옵저버 추가
    func addNotiObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleShowModalNotification(_:)), name: NSNotification.Name("notiData"), object: nil)
    }
    
    
    // 모달 창 띄우기
    @objc private func showOrderListModal() {
        let hasProducts = !basketViewController.orders.isEmpty
           print(hasProducts ? "상품 있음." : "상품 없음.")
           
           if let sheetViewController = basketViewController.sheetPresentationController {
               sheetViewController.detents = [.medium()]
               sheetViewController.preferredCornerRadius = 20
           }
           
           present(basketViewController, animated: true, completion: nil)
       }
    
    //버튼 숨기기 에니메이션
    @objc private func handleShowModalNotification(_ notification: Notification) {
            if let showModal = notification.userInfo?["showModal"] as? Bool {
                self.showModal = showModal
                print("showModal: \(showModal)")
            }
        self.orderListButton.snp.updateConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(-40) // 화면 바깥으로 이동
        }
        self.view.layoutIfNeeded()
        
            UIView.animate(withDuration: 0.5) {
                self.orderListButton.snp.updateConstraints {
                    $0.bottom.equalToSuperview().inset(40)
                }
                self.view.layoutIfNeeded()
            }
        }
}
