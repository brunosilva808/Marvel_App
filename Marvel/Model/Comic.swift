//
//  Image.swift
//  Marvel
//
//  Created by Bruno Silva on 17/11/2018.
//

import Foundation

struct Comic: Codable {
    let code: Int
}

struct Character: Codable {
    let code: Int
    let status: String
    let data: DataClass
}

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
//    let series: [Series]
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

//enum Extension: String, Codable {
//    case jpg = "jpg"
//}
