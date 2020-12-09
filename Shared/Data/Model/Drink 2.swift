//
//  File.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/4.
//

import Foundation

struct Drink: Codable, Identifiable {
    var id = 0
    var name = ""
    var menus: [DrinkMenu] = []
}
