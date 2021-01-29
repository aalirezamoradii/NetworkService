//
//  Requstable.swift
//  ServiceManager
//
//  Created by Alireza Moradi on 2/17/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public protocol Requestable: Codable , Request {
    static var header:[String:String] { get set }
}
public protocol Request {
    static var method: HttpMethod { get }
    static var url: String { get set }
    associatedtype ResponseType: Decodable
    associatedtype ResponseError: Decodable
}
public extension Requestable {
    static var method: HttpMethod {
        return .post
    }
    static var requestType: RequestType {
        switch method {
        case .post:
            return .jsonBody
        case .get:
            return .urlQuery
        default:
            return .jsonBody
        }
    }
    static var header:[String:String] { [:] }
}

