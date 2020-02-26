//
//  SignUpM.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import ServiceNetwork

struct SignUpM:Decodable, Requestable {
    
    static var header: [String : String] {
        [:]
    }
    public static var url: String { ApiURL.signUpURL }
    public static var requestType: RequestType { .jsonBody }
    public static var method: HttpMethod { .post }
    typealias ResponseType = SignUpM
    
    let phoneNumber:String
    
    public init(phoneNumber:String) {
        self.phoneNumber = phoneNumber
    }
}
