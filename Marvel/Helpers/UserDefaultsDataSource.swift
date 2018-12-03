//
//  UserDefaultsDataSource.swift
//  Marvel
//
//  Created by Bruno Silva on 03/12/2018.
//

import Foundation

enum UserDefaultsKeys {
    static let favouriteCharacter: String = "favouriteCharacterKey"
}

protocol DataSource: class {
    func writeData(_ data: Any, for key: String)
    func readData(for key: String) -> Any?
}

final class UserDefaultsDataSource: DataSource {
    
    func writeData(_ data: Any, for key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func readData(for key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
}
