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
    var totalPrice: Int
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
            items.append(BasketItem(coffee: coffee, numbers: 1, totalPrice: Int(coffee.menuPrice) ?? 0 ))
        }
    }
    
    // 지우기
    func deleteItem(_ coffee: CoffeeList) {
        if let index = items.firstIndex(where: { $0.coffee.menuName == coffee.menuName }) {
            items[index].numbers -= 1
            if items[index].numbers == 0 {
                items.remove(at: index)
            }else {
                return
            }
        }
    }
    
    // 삭제
    func removeItem(_ coffee: CoffeeList){
        if let index = items.firstIndex(where: { $0.coffee.menuName == coffee.menuName }) {
            items.remove(at: index)
        }
    }
    
    func clearAll() {
        items.removeAll()
    }
    
    // 계산로직
    func calculateTotalPrice() -> String {
        let totalPrice = items.reduce(0) { (result, item) -> Int in
            return result + (item.numbers * (Int(item.coffee.menuPrice) ?? 0))
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let formattedTotal = formatter.string(from: NSNumber(value: totalPrice)) {
            return formattedTotal
        } else {
            return "\(totalPrice)"  // 포맷 실패 시 일반 문자열로 반환
        }
    }
}
