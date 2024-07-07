//
//  DelegateReservoir.swift
//  MacAProject
//
//  Created by 머성이 on 7/5/24.
//

import Foundation

// 언더라인 관련
protocol KHMenuViewDelegate: AnyObject {
    func segmentValueChanged(to index: Int)
}

// 컬렉션 뷰 셀 관련
protocol SBMenuCollectionViewCellDelegate: AnyObject {
    func didSelectCountButton(CoffeeList: CoffeeList)
}

// 컬
protocol BasketViewControllerDelegate: AnyObject {
    func didUpdateBasket()
}

