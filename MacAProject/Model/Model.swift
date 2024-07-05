//
// Model.swift
// MacAProject
//
// Created by 머성이 on 7/2/24.
//
import Foundation

struct CoffeeList{
    
  let imageName: String
  let menuName: String
  let menuPrice: String
}

extension CoffeeList{
    
  static let recommended_Menu = [
    CoffeeList(imageName: "plain_PongCrush", menuName: "플레인 퐁크러쉬", menuPrice: "4500"),
    CoffeeList(imageName: "iced_Cue_Brat", menuName: "아이스 큐브라떼", menuPrice: "5200"),
    CoffeeList(imageName: "grapefruit_Ade", menuName: "자몽에이드", menuPrice: "4800"),
    CoffeeList(imageName: "iced_Apple_and_Citrus_Tea", menuName: "아이스 사과유자차", menuPrice: "5000"),
    CoffeeList(imageName: "strawberry_Latte", menuName: "딸기라떼", menuPrice: "5300"),
    CoffeeList(imageName: "potato_Bread", menuName: "감자빵", menuPrice: "4200")
  ]
    
  static let smoothie_Menu = [
    CoffeeList(imageName: "golden_Mango_Smoothie", menuName: "골드망고 스무디", menuPrice: "5800"),
    CoffeeList(imageName: "strawberry_Yogurt_Smoothie", menuName: "딸기요거트 스무디", menuPrice: "5500"),
    CoffeeList(imageName: "strawberry_Cookie_Frappe", menuName: "딸기쿠키 프라페", menuPrice: "5700"),
    CoffeeList(imageName: "cookie_Frappe", menuName: "쿠키프라페", menuPrice: "5600"),
    CoffeeList(imageName: "coconut_Coffee_Smoothie", menuName: "코코넛커피 스무디", menuPrice: "5900"),
    CoffeeList(imageName: "mint_Frappe", menuName: "민트프라페", menuPrice: "5400")
  ]
    
  static let coffee_Menu = [
    CoffeeList(imageName: "iced_Vanilla_Latte", menuName: "아이스 바닐라라떼", menuPrice: "4900"),
    CoffeeList(imageName: "iced_Americano", menuName: "아이스 아메리카노", menuPrice: "4000"),
    CoffeeList(imageName: "iscafemoca", menuName: "아이스 카페모카", menuPrice: "5300"),
    CoffeeList(imageName: "big_Hal_Mega_Coffee", menuName: "왕할메가커피", menuPrice: "6000"),
    CoffeeList(imageName: "cold_Brew_Latte", menuName: "콜드브루라떼", menuPrice: "5100"),
    CoffeeList(imageName: "iscara_melmakiatto", menuName: "아이스 카라멜마끼아또", menuPrice: "5500")
  ]
    
  static let dessert_Menu = [
    CoffeeList(imageName: "honey_bread", menuName: "허니브레드", menuPrice: "7000"),
    CoffeeList(imageName: "hot_Chicken_Deep_Cheese_Ciabatta", menuName: "핫치킨&딥치즈 치아바타", menuPrice: "6500"),
    CoffeeList(imageName: "cheesecake", menuName: "치즈케익", menuPrice: "5800"),
    CoffeeList(imageName: "choco_Gelato_Croiffle", menuName: "초코젤라또 크로플", menuPrice: "7200"),
    CoffeeList(imageName: "iced_Honey_Waansu", menuName: "아이스 허니와앙슈", menuPrice: "5000"),
    CoffeeList(imageName: "butter_Egg_Bacon_Sandwich", menuName: "버터버터에그 베이컨샌드위치", menuPrice: "6900")
  ]
    
  static let beverage_Menu = [
    CoffeeList(imageName: "cherry_Coke", menuName: "체리콕", menuPrice: "4500"),
    CoffeeList(imageName: "ice_Choco", menuName: "아이스초코", menuPrice: "4700"),
    CoffeeList(imageName: "ice_Grain_Latte", menuName: "아이스 곡물라떼", menuPrice: "4800"),
    CoffeeList(imageName: "peach_Ice_Tea", menuName: "복숭아 아이스티", menuPrice: "4500"),
    CoffeeList(imageName: "shine_Musket_Green", menuName: "샤인머스캣그린주스", menuPrice: "5200"),
    CoffeeList(imageName: "strawberry_Banana", menuName: "딸기바나나주스", menuPrice: "5300")
    
  ]
    
  static let do_not_eat_Menu = [
    CoffeeList(imageName: "wm_Juice", menuName: "수박주스", menuPrice: "5000"),
    CoffeeList(imageName: "bsbubblemt_Icedlatte", menuName: "흑당버블밀크티 아이스라떼", menuPrice: "5500"),
    CoffeeList(imageName: "bs_Icedbubblelatte", menuName: "아이스 흑당버블라떼", menuPrice: "5500"),
    CoffeeList(imageName: "cucumber_Limemojito", menuName: "오이오이 라임오히또", menuPrice: "4800"),
    CoffeeList(imageName: "grapefruit_honey_bt_Iced", menuName: "아이스 허니자몽블랙티", menuPrice: "4900"),
    CoffeeList(imageName: "ggultip_Option", menuName: "꿀팁옵션", menuPrice: "3800")
  ]
    
  static let tea_Menu = [
    CoffeeList(imageName: "chamomile_Tea", menuName: "캐모마일티", menuPrice: "5000"),
    CoffeeList(imageName: "citron_Tea", menuName: "유자차", menuPrice: "5500"),
    CoffeeList(imageName: "earlGrey_Tea", menuName: "얼그레이티", menuPrice: "5500"),
    CoffeeList(imageName: "green_Tea", menuName: "녹차", menuPrice: "4800"),
    CoffeeList(imageName: "honey_Grapefruit_BlackTea", menuName: "허니자몽블랙티", menuPrice: "4900"),
    CoffeeList(imageName: "royal_Milk_Tea", menuName: "로얄밀크티", menuPrice: "5000")
  ]
    
//  static let pong_crush_Menu = [
//    CoffeeList(imageName: "choco_Honey_PongCrush", menuName: "초코허니퐁크러쉬", menuPrice: 5300),
//    CoffeeList(imageName: "banana_PongCrush", menuName: "바나나퐁크러쉬", menuPrice: 5200),
//    CoffeeList(imageName: "strawberry_PongCrush", menuName: "딸기퐁크러쉬", menuPrice: 5400),
//    CoffeeList(imageName: "plain_PongCrush", menuName: "플레인퐁크러쉬", menuPrice: 4500),
//    CoffeeList(imageName: "custardCream_Honey_PongCrush", menuName: "슈크림허니퐁크러쉬", menuPrice: 5600)
//  ]
    
}

