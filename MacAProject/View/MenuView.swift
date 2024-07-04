//
//  MenuView.swift
//  MacAProject
//
//  Created by 머성이 on 7/4/24.
//

import UIKit
import SnapKit

class MenuView: UICollectionViewCell {
    
    // 이미지 뷰 생성
    let imgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // 레이블 뷰 생성
    let label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.clipsToBounds = true
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imgView)
        contentView.addSubview(label)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("*T_T*")
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        imgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(5)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview().inset(5)
        }
    }
}
