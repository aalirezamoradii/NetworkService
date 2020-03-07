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
    case invalidServer
    public var errorDescription: String? {
        return nil
    }
}
