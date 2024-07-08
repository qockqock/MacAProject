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
    let removeButton = UIButton(type: .system)
    
    var plusAction: (() -> Void)?
    var minusAction: (() -> Void)?
    var removeAction: (() -> Void)?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setupConstraints()
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        subtractButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        plusAction?()
    }
    
    @objc func minusButtonTapped() {
        minusAction?()
    }
    
    @objc func removeButtonTapped() {
        minusAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        [productImageView, productNameLabel, quantityLabel, addButton, subtractButton, priceLabel, removeButton].forEach{
            contentView.addSubview($0)
        }
        
        productImageView.contentMode = .scaleAspectFit
        productNameLabel.font = .boldSystemFont(ofSize: 16)
        
        quantityLabel.font = .systemFont(ofSize: 16)
        quantityLabel.textAlignment = .center
        
        priceLabel.font = .boldSystemFont(ofSize: 18)
        priceLabel.textAlignment = .right
        
        addButton.setTitle("+", for: .normal)
        addButton.layer.cornerRadius = 2
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .black
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        subtractButton.setTitle("-", for: .normal)
        subtractButton.layer.cornerRadius = 2
        subtractButton.setTitleColor(.white, for: .normal)
        subtractButton.backgroundColor = .black
        subtractButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        removeButton.setTitle("×", for: .normal)
        removeButton.layer.cornerRadius = 2
        removeButton.setTitleColor(.systemPink, for: .normal)
        removeButton.backgroundColor = #colorLiteral(red: 0.8749070764, green: 0.8814653754, blue: 0.9251363873, alpha: 1)
        removeButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    
    
    func setupConstraints() {
        productImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(75)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(10)
            $0.top.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.leading.equalTo(quantityLabel.snp.trailing)
            $0.top.equalTo(productNameLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(20)
        }
        
        quantityLabel.snp.makeConstraints {
            $0.leading.equalTo(subtractButton.snp.trailing)
            $0.centerY.equalTo(addButton.snp.centerY)
            $0.width.equalTo(50)
        }
        
        subtractButton.snp.makeConstraints {
            $0.leading.equalTo(productImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(addButton.snp.centerY)
            $0.width.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(subtractButton)
            $0.width.equalTo(80)
        }
        
        removeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(15)
            $0.width.height.equalTo(18)
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
