//
//  ParameterEncoding.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

enum HeaderConstant {
    struct type {
        static let contentType = "Content-Type"
    }
    struct value {
        static let urlEncoded = "application/x-www-form-urlencoded; charset=utf-8"
        static let applicationJson = "application/json"
    }
}

public typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {}

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
