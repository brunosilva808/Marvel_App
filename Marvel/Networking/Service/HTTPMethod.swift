//
//  HTTPMethod.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
    case options = "OPTIONS"
    case head    = "HEAD"
    case patch   = "PATCH"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
