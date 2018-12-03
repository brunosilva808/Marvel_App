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
    let comics, series, events: Comics
    let stories: Stories
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: ItemType
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case pinup = "pinup"
}
