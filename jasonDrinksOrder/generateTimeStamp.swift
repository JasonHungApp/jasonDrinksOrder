//
//  Tools.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/1.
//

import Foundation

//生成的時間戳
func generateTimeStamp(dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    let currentDate = Date()
    return dateFormatter.string(from: currentDate)
}


