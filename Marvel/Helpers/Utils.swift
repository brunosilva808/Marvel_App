//
//  Utils.swift
//  Marvel
//
//  Created by Bruno Silva on 03/12/2018.
//

import Foundation

typealias ResponseCallback<T> = (_ response: T) -> ()
typealias APIErrorCallback = (String) -> ()
typealias SimpleCallback = () -> ()
