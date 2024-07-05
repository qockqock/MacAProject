//
//  MenuCellView.swift
//  MacAProject
//
//  Created by DEUKRYEONG LEE on 7/5/24.
//

import UIKit
import SnapKit
//MARK: - MakeCell 클래스: 테이블뷰셀 클래스

class MakeCell: UITableViewCell {
    let contentLabel = UILabel()
    
    // 셀의 초기화 메서드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // contentLabel을 contentView에 추가하고 오토레이아웃 설정
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 셀에 들어갈 내용 구성 메서드
    func configure(){
        contentLabel.text = "Sample Text"
    }
}
