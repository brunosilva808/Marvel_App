//
//  APIConstants.swift
//  Marvel
//
//  Created by Bruno Silva on 04/12/2018.
//

import Foundation

enum APIConstant {
    
    static var baseURL = "https://gateway.marvel.com:443/v1/public"
    
    enum Header {
        static let contentType = "Content-Type"
    }
    
    enum Parameter {
        static let timeStamp = "ts"
        static let apiKey = "apikey"
        static let hash = "hash"
        static let limit = "limit"
        static let offset = "offset"
    }
    
    enum Value {
        static let timeoutInterval = 10.0
        static let timeStamp = "1"
        static let limit = 20
        static var publicKey = "2b78d362481839c76e3df81e3b13d6e5"
        static var privateKey = "a1b0fc8354dee2423349c6d1453dbc91a7716bc6"
    }
    
    enum Portrait1 {
        static let small = "/portrait_small"
        static let medium = "/portrait_medium"
        static let xlarge = "/portrait_xlarge"
        static let fantastic = "/portrait_fantastic"
    }
    
    enum Portrait {
        case small
        case medium
        case xlarge
        case fantastic
        case uncanny
        case incredible
        case Void()
    }
    
    //portrait_small    50x75px
    //portrait_medium    100x150px
    //portrait_xlarge    150x225px
    //portrait_fantastic    168x252px
    //portrait_uncanny    300x450px
    //portrait_incredible    216x324px
}
