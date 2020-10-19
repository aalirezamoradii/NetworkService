//
//  HttpMethod.swift
//  ServiceNetwork
//
//  Created by Alireza Moradi on 10/18/2020.
//

import Foundation
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
   public static let put = HttpMethod(rawValue: "PUT")

}
