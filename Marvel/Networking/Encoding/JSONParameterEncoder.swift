//
//  JSONParameterEncoder.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: HeaderConstant.type.contentType) == nil {
                urlRequest.setValue(HeaderConstant.value.applicationJson, forHTTPHeaderField: HeaderConstant.type.contentType)
            }
        } catch  {
            throw NetworkError.encodingFailed
        }
    }
}
