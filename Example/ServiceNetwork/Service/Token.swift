//
//  KeychinPassword.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/19/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation
struct Token {
    
    static let shared = Token()
    let credential:URLCredential
    
    init(user:String, password:String) {
        credential = URLCredential(user: user, password: password, persistence: .permanent)
        URLCredentialStorage.shared.set(credential, for: URLProtectionSpace())
    }
    init() {
        credential = URLCredential()
    }
    func get(key:String) -> String {
//        guard let storage = URLCredentialStorage.shared.credentials(for: URLProtectionSpace()) else { return "" }
//        guard let value = storage[key] else { return "" }
//        if value.user == key {
//            return value.password ?? ""
//        }
        return ""
    }
    func get(key:String) -> Int {
        guard let storage = URLCredentialStorage.shared.credentials(for: URLProtectionSpace()) else { return 0 }
        guard let value = storage[key] else { return 0 }
        if value.user == key {
            return Int(value.password ?? "") ?? 0
        }
        return 0
    }
    
}
