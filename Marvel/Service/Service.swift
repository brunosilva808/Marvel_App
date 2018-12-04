//
//  Service.swift
//  Marvel
//
//  Created by Bruno Silva on 16/11/2018.
//

import Foundation



//struct APIEndpoint {
//    static var comics = "/comics?"
//}

enum Endpoint {
    case comic
}

enum Filter {
    case cover
    case format
}

extension Service {
    
    private var timeStamp: String {
        return APIConstant.Parameter.timeStamp + APIConstant.Value.timeStamp
    }
    
    private var apiKey: String {
        return APIConstant.Parameter.apiKey + APIConstant.Value.publicKey
    }
    
    private var md5Digest: String {
        let digest = APIConstant.Value.timeStamp +
                APIConstant.Value.privateKey +
                APIConstant.Value.publicKey
            
        return "hash=" + "\(digest.utf8.md5)"
    }
    
    private func url(endpoint: Endpoint, filters: [Filter]? = []) -> URL {
        var urlString = APIConstant.baseURL
        
//        switch endpoint {
//        case .comic:
//            urlString += APIEndpoint.comics
//            break
//        }
        
        return URL(string: addParameters(urlString: urlString, filters: filters))!
    }
    
    private func addParameters(urlString: String, filters: [Filter]? = []) -> String {

        var parametersArray = [timeStamp, apiKey, md5Digest]
        
        if let array = filters {
            for filter in array {
                switch filter {
                case .cover:
                    parametersArray.append("format=hardcover")
                    break
                case .format:
                    parametersArray.append("formatType=comic")
                    break
                }
            }

        }
        
        return urlString + parametersArray.joined(separator: "&")
    }
    
    private var requestHTTPHeaders: [String : String] {
        let headers = [APIConstant.Header.contentType: "application/json"]
        return headers
    }
    
    private func request(endpoint: Endpoint, filters: [Filter]? = []) -> URLRequest {
        var request = URLRequest(url: url(endpoint: .comic, filters: filters))
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = requestHTTPHeaders
        
        return request
    }
    
    
    
}

final class Service {
    
    static var shared = Service()
    
    typealias APISuccessCallback<T> = (_ response: T) -> ()
    typealias APIErrorCallback = () -> ()
    
//    func getComics(filters: [Filter]? = [], onSuccess: @escaping APISuccessCallback<Comic>, onError: @escaping APIErrorCallback) {
//        URLSession.shared.dataTask(with: request(endpoint: .comic, filters: filters)) { (data, response, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//            
//            guard let data = data else { return }
//
//            do {
//                let comics = try JSONDecoder().decode(Comic.self, from: data)
//                onSuccess(comics)
//            } catch let jsonError {
//                print(jsonError.localizedDescription)
//                onError()
//            }
//            
//        }.resume()
//    }
//    
//    func getComics1(filters: [Filter]? = [], onSuccess: @escaping APISuccessCallback<Comic>, onError: @escaping APIErrorCallback) {
//        URLSession.shared.dataTask(with: request(endpoint: .comic, filters: filters)) { (data, response, error) in
//            guard let data = data else { return }
//            let comics = try? JSONDecoder().decode(Comic.self, from: data)
//
//            switch comics?.code {
//            case 200:
//                onSuccess(comics!)
//                break
//            default:
//                onError()
//                break;
//            }
//
//        }.resume()
//    }
    
    func getImageUrl(thumbnail: Thumbnail, size: APIConstant.Portrait) -> String {
        var urlString = thumbnail.path
        
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
        
        urlString += "." + thumbnail.thumbnailExtension
        
        return urlString
    }
    
}
