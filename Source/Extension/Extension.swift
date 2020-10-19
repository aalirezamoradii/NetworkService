//
//  Extension.swift
//  NetworkService
//
//  Created by Alireza Moradi on 2/19/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation
extension Encodable {
    
    private var objectDeserialaze: Any {
        get {
            do {
                let data = try JSONEncoder().encode(self)
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return dictionary
            } catch {
                return [:]
            }
        }
    }
    
    public var dictionary: [String:String] {
        get {
            return objectDeserialaze as? [String:String] ?? [:]
        }
    }
}

extension URLComponents {
    mutating func queryItems(with parameters: [String: Any]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}

extension Dictionary {
    mutating func merge(_ dictionary: Dictionary?) {
        if let dict = dictionary {
            for (key,value) in dict {
                updateValue(value, forKey: key)
            }
        }
    }
}
