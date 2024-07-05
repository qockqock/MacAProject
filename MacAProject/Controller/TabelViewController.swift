//
//  TabelViewController.swift
//  MacAProject
//
//  Created by DEUKRYEONG LEE on 7/5/24.
//

import UIKit
import SnapKit
import SwiftUI

//MARK: - TableViewController 클래스: 테이블뷰를 관리하는 클래스
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 테이블뷰 인스턴스 생성
    private let tableView = UITableView()
    
    var showModal = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터 소스와 델리게이트 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 셀 하나하나의 높이 설정
        tableView.rowHeight = 100
        
        // 셀을 재사용하기 위해 재사용 식별자를 테이블뷰에 등록
        tableView.register(MakeCell.self, forCellReuseIdentifier: "cellID")
        
        // 테이블뷰 오토레이아웃 설정 메서드 호출
        setupTableviewConstraints()
        
        // 결제 버튼 생성 메서드 호출
        //        paymentButton_Modal()
        
        paymentButton_Modal()
    }
    
    //MARK: - 모달 내부에 있는 결제 Btn 함수
    func paymentButton_Modal(){
        let orderListButton = UIButton()
        
        // 버튼의 타이틀, 색상, 배경색, 폰트 설정
        orderListButton.setTitle("결제하기", for: .normal)
        orderListButton.setTitleColor(.white, for: .normal)
        orderListButton.backgroundColor = #colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1)
        orderListButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        orderListButton.layer.cornerRadius = 15
        
        // 버튼을 뷰에 추가하고 오토레이아웃 설정
        self.view.addSubview(orderListButton)
        orderListButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.height.equalTo(65)
            $0.width.equalTo(350)
            $0.centerX.equalToSuperview()
        }
        
        // 버튼 클릭 시 paymentSuccessAlert 메서드를 호출하도록 설정
        orderListButton.addTarget(self, action: #selector(paymentSuccessAlert), for: .touchDown)
    }
    
    //MARK: - 결제 성공 알림 메서드 Alert
    @objc
    func paymentSuccessAlert() {
        let alert = UIAlertController(title: "결제 성공", message: "주문이 완료되었습니다.", preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "닫기", style: .default) { [self] (action) in
            // 현재 화면을 닫는 동작을 여기서 실행
            self.dismiss(animated: true, completion: nil)
            showModal = true
            //노티로 데이터 전달
            NotificationCenter.default.post(name: NSNotification.Name("notiData"), object:nil, userInfo: ["showModal" : showModal])
        }
        
        alert.addAction(closeAction)
        //alert창 띄우기
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // 테이블뷰 오토레이아웃 설정
    func setupTableviewConstraints(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 테이블뷰의 섹션당 셀의 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 // 실제 데이터로 변경 필요
    }
    
    // 셀의 내용을 설정하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? MakeCell else {
            return UITableViewCell()
        }
        
        // 셀 구성 및 선택 스타일 설정
        cell.configure()
        cell.selectionStyle = .none
        
        return cell
    }
}
