//
//  ServiceError.swift
//  ServiceManager
//
//  Created by Alireza Moradi on 2/17/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public enum ServiceError: LocalizedError {
    
    case badHttpStatus(status:Int,message:String?)
    case loginFaild(message:String?)
    case invalidResponse
    case invalidURL
    case invalidData
    public var errorDescription: String? {
        return nil
    }
}
public protocol EResponse: Decodable {
    
    var message: String { get }
    associatedtype fields: Decodable
    
//    init(message: String) {
//        self.message = message
//        //self.fields = feild
//    }
}
public struct ErrorResponse<T:Decodable>: EResponse {
    
    public var message: String
    
    public typealias fields = T
    
    init(message:String) {
        self.message = message
    }
    
}
public struct Xxxxx: Decodable {
    
}
