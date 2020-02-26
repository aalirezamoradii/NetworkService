//
//  SignUpVM.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

class SignUpVM {
    

    private var model:SignUpM {
        didSet {
            
        }
    }
    public var bool:((Bool) -> Void)?

    init(phoneNumber:String) {
        model = SignUpM(phoneNumber: phoneNumber)
    }
    public var phoneNumber:String {
        get {
            model.phoneNumber
        } set {
            model = SignUpM(phoneNumber: newValue)
        }
    }
    
    public func request() {
        Network.shared?.request(object: model, completionHandler: { response in
            switch response {
            case .failure(let erorr):
                switch erorr {
                case .badHttpStatus(let code, let message):
                    print(code,message ?? "")
                default:
                    break
                }
                self.bool?(false)
            case .success(let objects):
                print(objects)
                self.bool?(true)
            }
        })
    }
}
