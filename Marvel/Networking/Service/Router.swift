//
//  Router.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

class Router<Endpoint: EndpointType>: NetworkRouter {
    private var task: URLSessionTask?
    private var timeStamp: String {
        return APIConstant.Parameter.timeStamp + APIConstant.Value.timeStamp
    }
    
    private var apiKey: String {
        return APIConstant.Parameter.apiKey + APIConstant.Value.publicKey
    }
    
    private var md5Digest: String {
        let digest = APIConstant.Value.timeStamp +
            APIConstant.Value.privateKey +
            APIConstant.Value.publicKey
        
        return "\(digest.utf8.md5)"
    }
    
    func request(_ route: Endpoint, page: Int, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route, page: page)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
            task?.resume()
        } catch  {
            completion(nil, nil, error)
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: Endpoint, page: Int) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                request.setValue(HeaderConstant.value.applicationJson,
                                 forHTTPHeaderField: HeaderConstant.type.contentType)
            case .requestParameters(let bodyParameters,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            
            self.addURLQueryItems(request: &request, page: page)
            
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func addURLQueryItems(request: inout URLRequest, page: Int) {
        let queryItems = [URLQueryItem(name: APIConstant.Parameter.timeStamp, value: APIConstant.Value.timeStamp),
                          URLQueryItem(name: APIConstant.Parameter.apiKey, value: APIConstant.Value.publicKey),
                          URLQueryItem(name: APIConstant.Parameter.hash, value: md5Digest),
                          URLQueryItem(name: APIConstant.Parameter.limit, value: "\(APIConstant.Value.limit)"),
                          URLQueryItem(name: APIConstant.Parameter.offset, value: "\(APIConstant.Value.limit * page)")]

        if let urlString = request.url?.absoluteString {
            var urlComps = URLComponents(string: urlString)
            urlComps?.queryItems = queryItems
            request.url = urlComps?.url
        }
    }
        
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
