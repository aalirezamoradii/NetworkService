//
//  ServiceError.swift
//  NetworkService
//
//  Created by Alireza Moradi on 2/17/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public enum NSError<T>: LocalizedError where T : Decodable {
    
    case badHttpStatus(_ status:Int, _ error:T?, _ title:String)
    case loginFaild(_ message:String?)
    case invalidResponse
    case invalidURL
    case invalidData
    case invalidServer
    case timeOut
    case failure(_ error: Error)
    case error(_ error: T?)
    
    public var errorDescription: String? {
        return nil
    }
}
