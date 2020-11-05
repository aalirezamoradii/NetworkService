//
//  ServiceError.swift
//  NetworkService
//
//  Created by Alireza Moradi on 2/17/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public enum NTSError: LocalizedError {
    
    case badHttp(_ error: Decodable)
    case loginFaild(_ error: Decodable)
    case invalidResponse
    case invalidURL
    case invalidData
    case invalidServer
    case timeOut
    case failure(_ error: Error)
    
    public var errorDescription: String? {
        return nil
    }
}
