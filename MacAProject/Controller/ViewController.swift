// 뷰컨

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {
    
    let menuController = SBMenuController()
    let orderController  = OrderSheetController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

