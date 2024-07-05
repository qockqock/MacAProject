// 뷰컨

import UIKit
import SnapKit
import Lottie
import SwiftUI

class ViewController: UIViewController {
    
    let menuController = SBMenuController()
    let orderController  = OrderSheetController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //런치스크린
        let animationView: LottieAnimationView = .init(name: "coffee")
        animationView.frame = self.view.bounds  //전체화면
        animationView.contentMode = .scaleAspectFit  //화면에 가득 차게
        
        self.view.addSubview(animationView)
        
        animationView.play{ (finished) in
            if finished {
                // 애니메이션이 종료되면 animationView를 제거
                animationView.removeFromSuperview()
                self.setupCoffeeListView()
            }
        }
        
        print("Called ViewController - Run App")
        view.backgroundColor = .white
        
        setupControllers()
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
            make.height.equalTo(200) // 원하는 높이 설정
        }
    }
}
//
//struct PreView123: PreviewProvider {
//    static var previews: some View {
//        ViewController().toPreview123()
//    }
//}
//
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
//    func toPreview123() -> some View {
//        Preview(viewController: self)
//    }
//}
//#endif

