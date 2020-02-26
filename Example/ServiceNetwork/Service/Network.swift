//
//  Network.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import ServiceNetwork

class Network: Token {
    
    static var shared:Network? {
        Network(url: ApiURL.testURL, headers: headers)
    }
    private let service:Service
        
    init?(url:String, headers:[String:String]?) {
        guard let baseURL = URL(string: url) else { return nil }
        self.service = Service(baseURL: baseURL, baseHeader: headers)
    }
    public func request<T:Requestable>(object:T,completionHandler: @escaping (Result<T.ResponseType?,ServiceError>) -> Void) {
        service.request(object: object) { (response) in
            switch response {
            case .failure(let error):
                switch error {
                case .loginFaild(let message):
                    print(message ?? "")
                default:
                    print(error)
                }
            case .success(let success):
                completionHandler(.success(success))
                print(success)
            }
        }
    }
}
