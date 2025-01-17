// 뷰컨

import UIKit
import SnapKit
import Lottie

class ViewController: UIViewController {
    
    let menuController = SBMenuController()
    let orderController  = OrderSheetController()
    
    private func showLaunchScreen() {
        //런치스크린
        let animationView: LottieAnimationView = .init(name: "coffee")
        animationView.frame = self.view.bounds  //전체화면
        animationView.contentMode = .scaleAspectFit  //화면에 가득 차게
        animationView.animationSpeed = 2
        
        self.view.addSubview(animationView)
        
        animationView.play{ (finished) in
            if finished {
                // 애니메이션이 종료되면 animationView를 제거
                animationView.removeFromSuperview()
                self.setupControllers()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("Called ViewController - Run App")
        view.backgroundColor = .white
        showLaunchScreen()
    }
    
    private func setupControllers() {
        // menuController 추가 및 제약 조건 설정
        addChild(menuController)
        view.addSubview(menuController.view)
        menuController.didMove(toParent: self)
        
        // orderController 추가 및 제약 조건 설정
        addChild(orderController)
        view.addSubview(orderController.view)
        orderController.didMove(toParent: self)
        
        // menuController 제약 조건 설정
        menuController.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(orderController.view.snp.top)
        }
        
        // orderController 제약 조건 설정
        orderController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(250) // 원하는 높이 설정
        }
    }
}

