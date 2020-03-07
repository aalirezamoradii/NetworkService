//
//  Extension.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/19/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation
extension Encodable {
    public var dictionary:[String:Any] {
        get {
            do {
                let data = try JSONEncoder().encode(self)
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    return [:]
                }
                return dictionary
            } catch {
                return [:]
            }
        }
    }
    public var dict:[String:String] {
        get {
            do {
                let data = try JSONEncoder().encode(self)
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] else {
                    return [:]
                }
                return dictionary
            } catch {
                return [:]
            }
        }
    }
}
extension URLComponents {
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}
extension Dictionary {
    mutating func merge(dict:Dictionary?) -> Dictionary {
        if let dict = dict {
            for (key,value) in dict {
                updateValue(value, forKey: key)
            }
        }
        return self
    }
}
extension Data {
    
    public func json() -> [String:Any]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
                return json
            }
            return nil
        } catch {
            return nil
        }
    }
    
}
