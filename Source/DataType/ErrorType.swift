//
//  ErrorResponse.swift
//  NetworkService
//
//  Created by Alireza Moradi on 2/26/20.
//

import Foundation

public struct ErrorType<T: Decodable>: Decodable {
    let title:String
    let errors:T?
}
