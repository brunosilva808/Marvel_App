//
//  EndPointType.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

protocol HTTPEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
