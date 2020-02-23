//
//  SignUpM.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Service

struct SignUpM:Decodable, Requestable {
    
    public static var url: String { ApiURL.signUpURL }
    public static var requestType: RequestType { .urlQuery }
    public static var method: HttpMethod { .get }
    typealias ResponseType = SignUpResponse
    
    let phoneNumber:String
    let userType:String
    let invitationCode:String
    let operationSystemEnum:Int
    
    public init(phoneNumber:String) {
        self.phoneNumber = phoneNumber
        self.userType = "Driver"
        self.invitationCode = ""
        self.operationSystemEnum = 1
    }
}
struct SignUpResponse:Decodable {
    var status:Bool?
    var message:String?
    var data:Data?
    struct Data:Decodable, Encodable {
        var isNewUser:Bool?
        var isCompleteProfile:Bool?
    }
}
