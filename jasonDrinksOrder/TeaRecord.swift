//
//  StruckTeaRecord.swift
//  jasonDrinksOrder
//
//  Created by jasonhung on 2024/1/5.
//

import Foundation

struct TeaRecord: Codable {
    let records: [Tea]
}

struct Tea: Codable {
    let id: String
    let createdTime: String
    let fields: TeaFields
}

struct TeaFields: Codable {
    let category: String
    let name: String
    let hotAvailable: String
    let priceM: Int
    let priceL: Int
    let descriptionShort: String
    let descriptionLong: String
    let image: [TeaImage]
}

struct TeaImage: Codable {
    let id: String
    let width: Int
    let height: Int
    let url: String
    let filename: String
    let size: Int
    let type: String
    let thumbnails: TeaThumbnails
}

struct TeaThumbnails: Codable {
    let small: TeaThumbnail
    let large: TeaThumbnail
    let full: TeaThumbnail
}

struct TeaThumbnail: Codable {
    let url: String
    let width: Int
    let height: Int
}
