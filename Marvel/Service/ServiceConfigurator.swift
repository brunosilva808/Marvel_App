//
//  ServiceConfigurator.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

public enum ServiceRequestEncodingType {
    
    case url, json
}

public protocol ServiceConfigurator {
    
    var requestHTTPHeaders: [String: String] { get }
    var requestEncoding: ServiceRequestEncodingType { get }
}
