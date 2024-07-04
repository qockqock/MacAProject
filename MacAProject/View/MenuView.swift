//
//  MenuView.swift
//  MacAProject
//
//  Created by 머성이 on 7/4/24.
//

import UIKit
import SnapKit

class MenuView: UICollectionViewCell {
    // 이미지 정보
    let imgView: UIImageView = {
        let imgview = UIImageView()
        imgview.contentMode = . scaleToFill
        imgview.clipsToBounds = true
        return imgview
    }()
    
    // 음료 정보
    let label: UILabel = {
        let drink = UILabel()
        drink.backgroundColor = .white
        drink.textColor = .black
        drink.textAlignment = .center
        drink.font = UIFont.systemFont(ofSize: 14)
        return drink
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imgView)
        self.backgroundColor = .white
        setLayOut()
    }
    
    // 오토레이아웃 (이미지, 레이블)
    func setLayOut() {
        [imgView, label].forEach{
            self.contentView.addSubview($0)
        }
        imgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.height.equalTo(20) // 텍스트 높이
            $0.width.equalTo(110) // 텍스트 너비
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("*T_T*")
    }
}
