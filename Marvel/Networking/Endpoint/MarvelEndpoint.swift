//
//  Endpoint.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

enum NetworkEnvironment {
    case production
}

public enum MarvelAPI {
    case characters
}

extension MarvelAPI: HTTPEndpoint {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://gateway.marvel.com:443/v1/public/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .characters:
            return "characters"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }

}
