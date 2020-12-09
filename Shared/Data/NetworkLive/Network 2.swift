//
//  Network.swift
//  Starbucks (iOS)
//
//  Created by 小天才智能电脑 on 2020/12/6.
//

import Foundation

let baseUrl = "http://localhost:1337"


struct Network {
    static let findDrinks  = baseUrl     + "/drinks"
    
    static let createOrder = baseUrl     + "/orders"
    static let findOrders  = createOrder
    static let deleteOrder = createOrder + "/"
    static let updateOrder = createOrder + "/"
}
    
