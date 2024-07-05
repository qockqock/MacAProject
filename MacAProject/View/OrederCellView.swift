//
//  OrderMakeCell.swift
//  MacAProject
//
//  Created by DEUKRYEONG LEE on 7/5/24.
//

import UIKit
import SnapKit

class OrderMakeCell: UITableViewCell {
    //MARK: -  상수 선언
    let productImageView = UIImageView()
    let productNameLabel = UILabel()
    let quantityLabel = UILabel()
    let priceLabel = UILabel()
    let addButton = UIButton(type: .system)
    let subtractButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(quantityLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(subtractButton)
        contentView.addSubview(deleteButton)
        
        productImageView.contentMode = .scaleAspectFit
        productNameLabel.font = .systemFont(ofSize: 16)
        quantityLabel.font = .systemFont(ofSize: 16)
        priceLabel.font = .systemFont(ofSize: 16)
        
        addButton.setTitle("+", for: .normal)
        subtractButton.setTitle("-", for: .normal)
        deleteButton.setTitle("X", for: .normal)
        deleteButton.setTitleColor(.red, for: .normal)
    }
    
    func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        addButton.snp.makeConstraints { make in
            make.leading.equalTo(productNameLabel.snp.leading)
            make.top.equalTo(productNameLabel.snp.bottom).offset(10)
            make.width.height.equalTo(30)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.leading.equalTo(addButton.snp.trailing).offset(10)
            make.centerY.equalTo(addButton.snp.centerY)
        }
        
        subtractButton.snp.makeConstraints { make in
            make.leading.equalTo(quantityLabel.snp.trailing).offset(10)
            make.centerY.equalTo(addButton.snp.centerY)
            make.width.height.equalTo(30)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalTo(priceLabel.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure() {
        // 데이터에 따라 UI 요소 구성
        productImageView.image = UIImage(named: "sampleImage") // 샘플 이미지
        productNameLabel.text = "유니콘 매직 프라페(블루)"
        quantityLabel.text = "1개"
        priceLabel.text = "3,900원"
    }
}
