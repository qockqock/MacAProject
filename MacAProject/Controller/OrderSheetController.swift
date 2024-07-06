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
    
    // 알림 옵저버 추가
    func addNotiObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveNoti(_:)), name: NSNotification.Name("notiData"), object: nil)
    }
    
    // 알림을 받았을 때 호출되는 메서드
    @objc
    func didReceiveNoti(_ notification: Notification) {
        if let showModal = notification.userInfo?["showModal"] as? Bool {
            self.showModal = showModal
        }
    }
    
    // 모달 창 띄우기
    @objc
    func showOrderListModal() {
        
        if tvc.orders.isEmpty {
            print("아직 선택된 상품 없음.")
            if let sheetViewController = tvc.sheetPresentationController {
                sheetViewController.detents = [.medium()]
                sheetViewController.preferredCornerRadius = 20
            }
            self.present(tvc, animated: true, completion: nil)
        } else {
            if let sheetViewController = tvc.sheetPresentationController {
                sheetViewController.detents = [.medium()]
                sheetViewController.preferredCornerRadius = 20
            }
            self.present(tvc, animated: true, completion: nil)
        }
    }
}
