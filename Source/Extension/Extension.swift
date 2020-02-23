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
                do {
                    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                        return [:]
                    }
                    return dictionary
                } catch {
                    print(error)
                }
            } catch {
                print(error)
            }
            return [:]
        }
    }
}
extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}
