//
//  BasketViewController.swift
//  MacAProject
//
//  Created by 머성이 on 7/8/24.
//
//

import UIKit
import SnapKit

//MARK: - TableViewController 클래스: 테이블뷰를 관리하는 클래스
class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: BasketViewControllerDelegate?
    // 테이블뷰 인스턴스 생성
    private let tableView = UITableView()
    // 바스켓 -> 대성 추가
    let basket = Basket.stc
    
    var basketItem: BasketItem!
    
    // 얼럿 관련
    var showModal = false
    
    // 주문 목록 배열
    var orders:[CoffeeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 85
        tableView.register(OrderMakeCell.self, forCellReuseIdentifier: "cellID")
        
        setupTableviewConstraints()
        paymentButton_Modal()
        
    }
    
    
    //MARK: - 모달 내부에 있는 결제 Btn 함수
    func paymentButton_Modal() {
        let orderListLabel = UILabel()
        let totalPriceLabel = UILabel()
        var totalPriceNumLabel = UILabel()
        let paymentButton = UIButton()
        let deleteAllButton = UIButton()
        
        
        //모달 내부의 주문 내역 라벨
        orderListLabel.text = "주문 상품"
        orderListLabel.textColor = .black
        orderListLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        //총 상품 금액 라벨
        totalPriceLabel.text = "총 상품금액"
        totalPriceLabel.font = .systemFont(ofSize: 16)
        
        totalPriceNumLabel.text = "\(basketItem.totalPrice)"  //수정해주세요!! -> 했어여!!!!!!!!!
        totalPriceNumLabel.font = .boldSystemFont(ofSize: 20)
        totalPriceNumLabel.textColor = .red
        
        //결제하기 버튼의 타이틀, 색상, 배경색, 폰트 설정
        paymentButton.setTitle("결제하기", for: .normal)
        paymentButton.setTitleColor(.white, for: .normal)
        paymentButton.backgroundColor = #colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1)
        paymentButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        paymentButton.layer.cornerRadius = 10
        
        //전체 삭제 버튼의 타이틀, 색상, 배경색, 폰트 설정
        deleteAllButton.setTitle("전체삭제", for: .normal)
        deleteAllButton.setTitleColor(#colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1), for: .normal)
        deleteAllButton.backgroundColor = #colorLiteral(red: 0.9085021615, green: 0.8936178088, blue: 0.8809486628, alpha: 1)
        deleteAllButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        deleteAllButton.layer.cornerRadius = 10
        
        
        // 뷰에 버튼, 총 주문금액 ,라벨 추가하고 오토레이아웃 설정
        [orderListLabel,totalPriceLabel, totalPriceNumLabel, paymentButton, deleteAllButton].forEach { view.addSubview($0)
        }
        
        orderListLabel.snp.makeConstraints {
            $0.leading.equalTo(deleteAllButton.snp.leading)
            $0.top.equalToSuperview().inset(20)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(deleteAllButton.snp.leading)
            $0.bottom.equalTo(paymentButton.snp.top).offset(-10)
        }
        
        totalPriceNumLabel.snp.makeConstraints {
            $0.trailing.equalTo(paymentButton.snp.trailing).offset(-5)
            $0.bottom.equalTo(paymentButton.snp.top).offset(-10)
        }
        
        deleteAllButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(58)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(170)
        }
        
        paymentButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(58)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(170)
        }
        paymentButton.addTarget(self, action: #selector(paymentSuccessAlert), for: .touchDown)
        
        //전체삭제 버튼 클릭 시 메서드
        deleteAllButton.addTarget(self, action: #selector(delteAll), for: .touchDown)
        
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
            delteAll()
        }
        alert.addAction(closeAction)
        
        //alert창 띄우기
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func delteAll(){
        Basket.stc.clearAll()
        tableView.reloadData()
    }
    
    @objc func paymentButtonTapped() {
        // 결제 로직이 성공적으로 끝났다고 가정하고 paymentSuccessAlert를 호출합니다.
        paymentSuccessAlert()
    }
    
    
    // 테이블뷰 오토레이아웃 설정
    func setupTableviewConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.top.equalToSuperview().inset(55)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    
    func addOrder(imageName: String, menuName: String, menuPrice: String) {
        let menuItem = CoffeeList(imageName: imageName, menuName: menuName, menuPrice: menuPrice)
        orders.append(menuItem)
        
        // 주문이 추가된 후, 필요한 UI 업데이트 등을 수행할 수 있습니다.
        print("Added Order: \(menuItem.menuName)")
        
        // 예시로, 주문이 추가될 때마다 테이블 뷰를 다시 로드하는 코드를 추가할 수 있습니다.
        tableView.reloadData()
    }
    
    
    //MARK: - UITableViewDataSource Methods
    
    // 테이블뷰의 섹션당 셀의 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.items.count
    }
    
    
    // 셀의 내용을 설정하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? OrderMakeCell else {
            return UITableViewCell()
        }
        
        // 대성 추가
        let order = basket.items[indexPath.row]
        
        var num = 0
        
        cell.productImageView.image = UIImage(named: order.coffee.imageName)
        cell.productNameLabel.text = order.coffee.menuName
        cell.quantityLabel.text = "\(order.numbers)개"
        cell.priceLabel.text = "\(order.coffee.menuPrice)원"
        cell.selectionStyle = .none // 셀 선택 시 색상 변하지 않게 설정
        
        if let menuPrice = Int(order.coffee.menuPrice) {
            let priceTotal = Int(menuPrice * order.numbers)
            cell.priceLabel.text = "\(priceTotal)원"
            
            num += priceTotal
        }
        
            cell.plusAction = {
                self.increaseQuantity(at: indexPath)
                order.totalPrice += num
            }
            // 감소 액션 처리
            cell.minusAction = {
                self.decreaseQuantity(at: indexPath)
                order.totalPrice -= num
            }

        return cell
        }

        func increaseQuantity(at indexPath: IndexPath) {
            let coffeeItem = basket.items[indexPath.row].coffee
            Basket.stc.addItem(coffeeItem)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            delegate?.didUpdateBasket()
        }

        func decreaseQuantity(at indexPath: IndexPath) {
            let coffeeItem = basket.items[indexPath.row].coffee
            Basket.stc.removeItem(coffeeItem)
            tableView.reloadData()
            delegate?.didUpdateBasket()
        }

}
