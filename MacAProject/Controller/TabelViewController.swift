import UIKit
import SnapKit

//MARK: - TableViewController 클래스: 테이블뷰를 관리하는 클래스
class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 테이블뷰 인스턴스 생성
    private let tableView = UITableView()
    
    // 바스켓 대성 추가
    let basket = Basket.stc
    
    // 얼럿 관련
    var showModal = false
    
//    var menuItem: CoffeeList?
    
    var orders:[CoffeeList] = []
    
    // 샘플 데이터 배열 추가
//    let sampleData = [
//        ("유니콘 매직 프라페(블루)", 100, 39000),
//        ("유니콘 매직 프라페(레드)", 2, 4000),
//        ("유니콘 매직 프라페(그린)", 1, 4100)
//    ]
    
    
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
        let orderListButton = UIButton()
        let orderListLabel = UILabel()
        let totalPriceLabel = UILabel()
        var totalPriceNumLabel = UILabel()
        
        //모달 내부의 주문 내역 라벨
        orderListLabel.text = "주문 상품"
        orderListLabel.textColor = .black
        orderListLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        //총 상품 금액 라벨
        totalPriceLabel.text = "총 상품금액"
        totalPriceLabel.font = .systemFont(ofSize: 16)
        
        totalPriceNumLabel.text = "19,000원"  //수정해주세요!!
        totalPriceNumLabel.font = .boldSystemFont(ofSize: 20)
        totalPriceNumLabel.textColor = .red
        
        // 버튼의 타이틀, 색상, 배경색, 폰트 설정
        orderListButton.setTitle("결제하기", for: .normal)
        orderListButton.setTitleColor(.white, for: .normal)
        orderListButton.backgroundColor = #colorLiteral(red: 0.2734747827, green: 0.1341301203, blue: 0.003133529332, alpha: 1)
        orderListButton.titleLabel?.font = .boldSystemFont(ofSize: 22)
        orderListButton.layer.cornerRadius = 10
        
        // 뷰에 버튼, 총 주문금액 ,라벨 추가하고 오토레이아웃 설정
        [orderListLabel,totalPriceLabel, totalPriceNumLabel, orderListButton].forEach { view.addSubview($0) }
        
        orderListLabel.snp.makeConstraints {
            $0.leading.equalTo(orderListButton.snp.leading)
            $0.top.equalToSuperview().inset(20)
        }
        
        totalPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(orderListButton.snp.leading)
            $0.bottom.equalTo(orderListButton.snp.top).offset(-10)
        }
        
        totalPriceNumLabel.snp.makeConstraints {
            $0.trailing.equalTo(orderListButton.snp.trailing)
            $0.bottom.equalTo(orderListButton.snp.top).offset(-10)
        }
        
        orderListButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(58)
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
        cell.productImageView.image = UIImage(named: order.coffee.imageName)
        cell.productNameLabel.text = order.coffee.menuName
        cell.quantityLabel.text = "\(order.numbers)개"
        cell.priceLabel.text = "\(order.coffee.menuPrice)원"
        
        return cell
    }

}
