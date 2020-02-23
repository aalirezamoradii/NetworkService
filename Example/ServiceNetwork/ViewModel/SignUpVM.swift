//
//  SignUpVM.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

class SignUpVM {
    
    private var model:SignUpResponse! {
        didSet {
            print("set")
        }
    }
    private var parameters:SignUpM {
        didSet {
            
        }
    }
    public var bool:((Bool) -> Void)?

    init(phoneNumber:String) {
        parameters = SignUpM(phoneNumber: phoneNumber)
    }
    public var phoneNumber:String {
        get {
            parameters.phoneNumber
        } set {
            parameters = SignUpM(phoneNumber: newValue)
        }
    }
    
    public func request() {
        Network.shared?.request(object: parameters, completionHandler: { response in
            switch response {
            case .failure(let erorr):
                self.bool?(false)
            case .success(let objects):
                self.model = objects
                self.bool?(true)
            }
        })
    }
}
