//
//  NetworkManager+Comics.swift
//  Marvel
//
//  Created by Bruno Silva on 02/12/2018.
//

import Foundation

extension NetworkManager {
    
    func getCharacters(page: Int, onSuccess: @escaping ResponseCallback<Character>, onError: @escaping APIErrorCallback, onFinally: @escaping SimpleCallback) {
        router.request(.characters, page: page) { data, response, error in
            
            if error != nil {
                onError()
            }
            
            guard let data = data else { return }
            
//            let string1 = String(data: data, encoding: String.Encoding.utf8) ?? "Data could not be printed"
//            print(string1)
            
            do {
                let characters = try JSONDecoder().decode(Character.self, from: data)
                onSuccess(characters)
            } catch let jsonError {
                print(jsonError.localizedDescription)
                onError()
            }
            
            onFinally()
        }
    }
    
//    func getComics(filters: [Filter]? = [], onSuccess: @escaping APISuccessCallback<Comic>, onError: @escaping APIErrorCallback) {
//        URLSession.shared.dataTask(with: request(endpoint: .comic, filters: filters)) { (data, response, error) in
//            if error != nil {
//                print(error!.localizedDescription)
//            }
//
//            guard let data = data else { return }
//
//            do {
//                let comics = try JSONDecoder().decode(Comic.self, from: data)
//                onSuccess(comics)
//            } catch let jsonError {
//                print(jsonError.localizedDescription)
//                onError()
//            }
//
//            }.resume()
//    }
    
}
