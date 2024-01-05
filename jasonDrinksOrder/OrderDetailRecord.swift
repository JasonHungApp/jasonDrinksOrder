//
//  OrderDetailRecord.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/5.
//

import Foundation

struct OrderDetailRecord: Codable {
    let records: [OrderDetail]
}

struct OrderDetail: Codable {
//    let id: String
//    let createdTime: String
    var fields: OrderDetailFields
}

struct OrderDetailFields: Codable {
    var orderId: String
    var userId: String
    var drinkName: String
    var numberOfCups: Int
    var iceLevel: String
    var sugarLevel: String
    var cupLevel: String
    var toppings: String?
    var totalAmount: Int
    var timeStamp: String
}
