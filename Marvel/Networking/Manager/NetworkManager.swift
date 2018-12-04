//
//  NetworkManager.swift
//  Marvel
//
//  Created by Bruno Silva on 02/12/2018.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    let router = Router<MarvelAPI>()
    
    func getResourceUri(urlString: String, onSuccess: @escaping ResponseCallback<DataClass>, onError: @escaping APIErrorCallback, onFinally: @escaping SimpleCallback) {
        
        router.request(urlString: urlString) { (data, response, error) in
            if error != nil {
                onError(error?.localizedDescription ?? NetworkResponse.failed.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let data = data else { return }
                    
                    //                    let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                    //                    print("\(urlString) \(string1)")
                    
                    do {
                        let result = try JSONDecoder().decode(MarvelResponse.self, from: data)
                        
                        if let data = result.data {
                            onSuccess(data)
                        } else if let message = result.message {
                            onError(message)
                        } else {
                            onError(NetworkResponse.unableToDecode.rawValue)
                        }
                    } catch let jsonError {
                        onError(jsonError.localizedDescription)
                    }
                case .failure(let failure):
                    onError(failure)
                }
            }
            
            onFinally()
        }
    }
    
    func getData(endpoint: MarvelAPI, page: Int, onSuccess: @escaping ResponseCallback<DataClass>, onError: @escaping APIErrorCallback, onFinally: @escaping SimpleCallback) {
        
        router.request(endpoint, page: page) { data, response, error in
            
            if error != nil {
                onError(error?.localizedDescription ?? NetworkResponse.failed.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let data = data else { return }
                    
                    do {
                        let result = try JSONDecoder().decode(MarvelResponse.self, from: data)
                        
                        if let data = result.data {
                            onSuccess(data)
                        } else if let message = result.message {
                            onError(message)
                        } else {
                            onError(NetworkResponse.unableToDecode.rawValue)
                        }
                    } catch let jsonError {
                        onError(jsonError.localizedDescription)
                    }
                case .failure(let failure):
                    onError(failure)
                }
            }
            
            onFinally()
        }
        
    }
    
}

extension NetworkManager {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> HTTPResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum HTTPResult<String>{
    case success
    case failure(String)
}
