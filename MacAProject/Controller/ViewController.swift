// 뷰컨

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let coffeeListView = CategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCoffeeListView()
    }
    
    private func setupCoffeeListView() {
        coffeeListView.delegate = self
        view.addSubview(coffeeListView)
        coffeeListView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
}

extension ViewController: CoffeeListViewDelegate {
    func segmentValueChanged(to index: Int) {
        coffeeListView.collectionView.reloadData()
    }
    
    func configureCollectionViewConstraints() {
        // Additional constraints can be added here if needed
    }
    
    func configureCollectionViewAppearance() {
        coffeeListView.collectionView.backgroundColor = .white
    }
}
