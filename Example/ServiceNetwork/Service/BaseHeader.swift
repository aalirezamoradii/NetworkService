//
//  SaveData.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 3/3/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation
struct BaseHeader:Header {
    
    let contentType:String
    let appVersion:String
    let osType:String

    enum CodingKeys: String, CodingKey {
        case contentType = "Content-Type"
        case appVersion = "AppVersion"
        case osType = "OsType"
    }
    static var header: [String : String] {
        BaseHeader(contentType: "application/json", appVersion: "1.0", osType: "IOS").dict
    }
}
