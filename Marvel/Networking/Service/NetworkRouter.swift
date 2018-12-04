//
//  NetworkRouter.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype Endpoint: HTTPEndpoint
    func request(_ route: Endpoint, page: Int, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
