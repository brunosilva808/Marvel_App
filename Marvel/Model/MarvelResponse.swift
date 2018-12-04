//
//  Image.swift
//  Marvel
//
//  Created by Bruno Silva on 17/11/2018.
//

import Foundation

struct MarvelResponse: Codable {
    let code: Int?
    let status: String?
    let message: String?
    let data: DataClass?
}

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String?
    let title: String?
    let issueNumber: Int?
    let thumbnail: Thumbnail
    let comics, series, events, stories: Comics?
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    func getImageUrl(size: APIConstant.Portrait) -> String {
        var urlString = self.path
        
        switch size {
        case .small:
            urlString += "/portrait_small"
            break
        case .medium:
            urlString += "/portrait_medium"
            break
        case .xlarge:
            urlString += "/portrait_xlarge"
            break
        case .fantastic:
            urlString += "/portrait_fantastic"
            break
        case .uncanny:
            urlString += "/portrait_uncanny"
            break
        case .incredible:
            urlString += "/portrait_incredible"
            break
        default:
            break
        }
        
        urlString += "." + self.thumbnailExtension
        
        return urlString
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
}

//struct ComicsItem: Codable {
//    let resourceURI: String
//    let name: String
//}
//
//struct Stories: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [StoriesItem]
//    let returned: Int
//}
//
//struct StoriesItem: Codable {
//    let resourceURI: String
//    let name: String
//    let type: ItemType
//}
//
//enum ItemType: String, Codable {
//    case cover = "cover"
//    case empty = ""
//    case interiorStory = "interiorStory"
//    case pinup = "pinup"
//}
