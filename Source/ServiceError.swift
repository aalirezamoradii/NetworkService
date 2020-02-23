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
    public var errorDescription: String? {
        return nil
    }
}
public struct ErrorResponse: Codable {
    
    let message: String
    let feild: Int
    init(message: String, feild: Int) {
        self.message = message
        self.feild = feild
    }
}
