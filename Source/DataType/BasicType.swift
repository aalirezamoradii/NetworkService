//
//  BasicType.swift
//  ServiceManager
//
//  Created by Alireza Moradi on 2/17/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public protocol BasicType: Codable ,Hashable , RawRepresentable , CustomStringConvertible , CustomDebugStringConvertible {
    

    
}
extension BasicType where RawValue == String {
    public var description: String {
        rawValue
    }
    public var debugDescription: String {
        rawValue
    }
}
extension BasicType where RawValue == Int {
    public var description: String {
        String(describing: rawValue)
    }
    public var debugDescription: String {
        String(describing: rawValue)
    }
}
