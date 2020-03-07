//
//  SignUpM.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import ServiceNetwork

struct SignUpM:Decodable, Requestable {
    
    static var url: String { ApiURL.signUpURL }
    static var requestType: RequestType { .jsonBody }
    static var method: HttpMethod { .post }
    typealias ResponseType = SignUpM
    typealias ResponseError = SignUpMError
    static var header: [String : String] { [:] }

    let phoneNumber:String
    init(phoneNumber:String) {
        self.phoneNumber = phoneNumber
    }
    
}
struct SignUpMError:Decodable {
    let phoneNumber:[String]
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "PhoneNumber"
    }
}
struct SignUpHeader:Encodable {
    
}
