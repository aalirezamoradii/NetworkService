//
//  Requstable.swift
//  ServiceManager
//
//  Created by Alireza Moradi on 2/17/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public protocol Requestable: Encodable {
    
    static var method:HttpMethod { get }
    static var url: String { get }
    static var requestType: RequestType { get }
    static var header: [String:String] { get }
    associatedtype ResponseType: Decodable
}
public extension Requestable {
    
    static var method: HttpMethod {
        return .post
    }
    static var requestType: RequestType {
        switch method {
        case .post:
            return .jsonBody
        default:
            return .urlQuery
        }
    }
}
 public struct HttpMethod: BasicType {
    
    public let rawValue: String
    
    public var description: String { return rawValue }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    public init(description: String) {
        rawValue = description.uppercased()
    }
    public static let get = HttpMethod(rawValue: "Get")
    public static let post = HttpMethod(rawValue: "POST")
    public static let delete = HttpMethod(rawValue: "DELETE")
    public static let head = HttpMethod(rawValue: "HEAD")
    public static let patch = HttpMethod(rawValue: "PATCH")

    
}
public enum RequestType {
    case httpHeader
    case jsonBody
    case multipartFormData
    case urlQuery
}
