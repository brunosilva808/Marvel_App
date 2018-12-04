//
//  APICallHelper.swift
//  Move Me
//
//  Created by Artem Umanets on 29/05/2018.
//  Copyright © 2018 Carbon by Bold. All rights reserved.
//

import Foundation

fileprivate enum APICallRequestState {
    case started
    case success, failure
}

enum APICallRequest: String {
    
    case comics, events, stories, series
}

class APICallHelper {
    
    private var apiCalls: [APICallRequest: APICallRequestState] = [:]
    
    var onCompletion: SimpleCallback?
    
    func started(request: APICallRequest) {
        self.apiCalls[request] = APICallRequestState.started
    }
    
    func finished(request: APICallRequest, success: Bool) {
        self.apiCalls[request] = success ? APICallRequestState.success : APICallRequestState.failure
        if self.allRequestsFinished {
            self.onCompletion?()
        }
    }
    
    var allRequestsFinished: Bool {
        return !self.apiCalls.contains { $0.value == APICallRequestState.started }
    }
    
    var hasError: Bool {
        return self.apiCalls.contains { $0.value == APICallRequestState.failure }
    }
    
    func reset() {
        self.apiCalls.removeAll()
    }
}
