//
//  OrderSheetController.swift
//  MacAProject
//
//  Created by ahnzihyeon on 7/4/24.
//

import UIKit
import SwiftUI
import SnapKit



//MakeCell 클래스: 테이블뷰셀 클래스
class MakeCell: UITableViewCell {
    let contentLabel = UILabel()
    
    //셀의 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //셀에 들어갈 내용
    func configure(){
        contentLabel.text = "Sample Text"
    }
}


//TableViewController 클래스
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //테이블뷰 인스턴스 생성
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 100 //셀 하나하나의 높이
        
        //cell을 재사용하기 위해 재사용 식별자를 테이블뷰에 등록
        tableView.register(MakeCell.self, forCellReuseIdentifier: "cellID")
        
        //테이블뷰 오토레이아웃 설정 메서드 호출
        setupTableviewConstraints()
        paymentButton()
        
    }
    
    //모달 안에 있는 결제하기 버튼
    func paymentButton(){
        let orderListButton = UIButton()
        
        orderListButton.setTitle("결제하기", for: .normal)
        orderListButton.setTitleColor(.white, for: .normal)
        orderListButton.backgroundColor = #colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1)
        orderListButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        orderListButton.layer.cornerRadius = 15
        
        self.view.addSubview(orderListButton)
        
        orderListButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(65)
            $0.width.equalTo(350)
            $0.centerX.equalToSuperview()
        }
        
        orderListButton.addTarget(self, action: #selector(paymentSuccessAlert), for: .touchDown)
    }
    
    @objc
    func paymentSuccessAlert() {
        let alert = UIAlertController(title: "결제 성공", message: "주문이 완료되었습니다.", preferredStyle: .alert)
        
        
        let closeAction = UIAlertAction(title: "닫기", style: .default, handler: nil)
        
        alert.addAction(closeAction)
        
        //alert창 띄우기
        self.present(alert, animated: true, completion: nil)
    }
    
    //테이블뷰 오토레이아웃 설정
    func setupTableviewConstraints(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return cartArray.count  //아직 값을 받아 오지 않았기 때문에 일단 주석 -> 리턴값은 테이블뷰에 전달
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀을 재사용하기 위해 큐에서 꺼내서 캐스팅
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? MakeCell else {   //MakeCell을 타입 캐스팅
            return UITableViewCell()
        }
        
        cell.configure() // 셀을 구성하는 메서드 호출
        cell.selectionStyle = .none // 셀 선택 시 색상 변하지 않게 설정
        
        return cell
    }
    
}


//ViewController 역할
class OrderSheetController: UIViewController {
    
    //홈에 있는 주문하기 버튼
    func paymentButton(){
        let orderListButton = UIButton()
        
        orderListButton.setTitle("주문 내역", for: .normal)
        orderListButton.setTitleColor(.white, for: .normal)
        orderListButton.backgroundColor = #colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1)
        orderListButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        orderListButton.layer.cornerRadius = 15
        
        self.view.addSubview(orderListButton)
        
        orderListButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(65)
            $0.width.equalTo(350)
            $0.centerX.equalToSuperview()
        }

        
        orderListButton.addTarget(self, action: #selector(ShowOderList), for: .touchDown)
        
        
    }
    
    @objc
    func ShowOderList(){
        let tvc = TableViewController()
        
        if let orderSheet = tvc.sheetPresentationController {
            orderSheet.detents = [.medium()]
            orderSheet.preferredCornerRadius = 20
            /// 상단 -- 부여 잡는 부분 보이게 할것인지!
            orderSheet.prefersGrabberVisible = true
        }
        self.present(tvc, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentButton()
        
    }
    
    
}








struct PreView: PreviewProvider {
    static var previews: some View {
        OrderSheetController().toPreview()
        
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




