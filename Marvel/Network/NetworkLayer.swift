//
//  NetworkLayer.swift
//  Marvel
//
//  Created by Bruno Silva on 01/12/2018.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

final class NetworkLayer {
    
    static var shared = NetworkLayer()
    static let genericError = "Something went wrong. Please try again later"
    
    func get<T: Decodable>(request: ServiceRequest,
                           headers: [String: String] = [:],
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping ErrorHandler) {

        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(NetworkLayer.genericError)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(NetworkLayer.genericError)
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }
            errorHandler(NetworkLayer.genericError)
        }
        
        if let url = URL(string: request.url) {
            var dataRequest = URLRequest(url: url)
            dataRequest.allHTTPHeaderFields = request.HTTPHeaders
            URLSession.shared.dataTask(with: dataRequest, completionHandler: completionHandler).resume()
        }
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
}
