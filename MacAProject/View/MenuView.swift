//
//  MenuView.swift
//  MacAProject
//
//  Created by 머성이 on 7/4/24.
//

import UIKit
import SnapKit

class MenuView: UICollectionViewCell {

    let imgView: UIImageView = {
        let imgview = UIImageView()
        imgview.contentMode = . scaleToFill
        imgview.clipsToBounds = true
        return imgview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
