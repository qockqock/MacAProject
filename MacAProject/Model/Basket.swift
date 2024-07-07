//
//  Basket.swift
//  MacAProject
//
//  Created by 머성이 on 7/8/24.
//

import Foundation

struct BasketItem{
    let coffee: CoffeeList
    var numbers: Int // 갯수
}

class Basket{
    static let stc = Basket()
    var items: [BasketItem] = []
    
    private init(){}
    
    // 추가
    func addItem(_ coffee: CoffeeList) {
        if let index = items.firstIndex(where: { $0.coffee.menuName == coffee.menuName }) {
            items[index].numbers += 1
        } else {
            items.append(BasketItem(coffee: coffee, numbers: 1))
        }
    }
    
    // 삭제
    func removeItem(_ coffee: CoffeeList) {
        if let index = items.firstIndex(where: { $0.coffee.menuName == coffee.menuName }) {
            items[index].numbers -= 1
            if items[index].numbers == 0 {
                items.remove(at: index)
            }
        }
    }
    
    // 초기화
    func clearAll() {
        items.removeAll()
    }
}
