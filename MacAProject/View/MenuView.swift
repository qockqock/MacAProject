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
    
    // 음료이름 레이블 생성
    let beverageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.backgroundColor = .white
        lbl.clipsToBounds = true
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let pl = UILabel()
        pl.textAlignment = .center
        pl.backgroundColor = .white
        pl.textColor = .black
        pl.clipsToBounds = true
        pl.numberOfLines = 0
        pl.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return pl
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("*T_T*")
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        
        [imgView, beverageLabel, priceLabel].forEach {
            self.addSubview($0)
        }
        
        imgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
        }
        
        beverageLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(0) //솔비 변경
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
//            make.height.greaterThanOrEqualTo(30)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
    }
}
