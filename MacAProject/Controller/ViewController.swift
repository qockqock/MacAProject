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
        
        setupMenuController()
        
    }
    
    private func setupMenuController() {
        addChild(menuController)
        view.addSubview(menuController.view)
        view.addSubview(orderController.view)
        menuController.didMove(toParent: self)
        
        menuController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        orderController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
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

