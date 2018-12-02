//
//  Request.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

struct Request {}

extension Request {
    
    struct Comic: ServiceRequest {
        var endpoint: ServiceEndpoint { return APIEndpoint.comics}
    }
}
