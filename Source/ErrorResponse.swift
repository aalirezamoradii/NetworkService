//
//  ErrorResponse.swift
//  Pods-Netbar Drivers
//
//  Created by Alireza Moradi on 2/26/20.
//

import Foundation

public struct ErrorResponse<T: Decodable>: Decodable {
    let title:String
    let errors:T?
}
