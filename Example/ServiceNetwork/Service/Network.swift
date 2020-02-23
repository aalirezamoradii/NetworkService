//
//  Network.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation
import Service

class Network {
    
    static var shared:Network? {
        Network(url: ApiURL.baseURL, header: Token.shared.get(key: "token"))
    }
    private let service:Service
        
    init?(url:String, header:String) {
        guard let baseURL = URL(string: url) else { return nil }
        self.service = Service(baseURL: baseURL, header: header)
    }
    public func request<T:Requestable>(object:T,completionHandler: @escaping (Result<T.ResponseType,ServiceError>) -> Void) {
        service.request(object: object) { (response) in
            switch response {
            case .failure(let error):
                switch error {
                case .loginFaild(let message):
                    print(message ?? "")
                default:
                    break
                }
            case .success(let success):
                completionHandler(.success(success))
            }
        }
    }
}
