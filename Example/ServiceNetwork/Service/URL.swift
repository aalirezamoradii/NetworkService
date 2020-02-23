//
//  URL.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation
struct ApiURL {
    
    private static var apiVersion:Int {
        get { 2 }
        set { }
    }
    private static var version:String {
        String(describing: apiVersion)
    }
    static var baseURL:String {
        "https://testapinetbar.netbar.ir/api/"
    }
    static var signUpURL:String {
        "Verification/GetSms"
    }
    
    
}
