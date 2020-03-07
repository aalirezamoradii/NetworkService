
//
//  Network.swift
//  Netbar Drivers
//
//  Created by Alireza Moradi on 2/18/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import ServiceNetwork

class Network {
    
    static var shared:Network? {
        Network(url: ApiURL.baseURL, header: BaseHeader.header)
    }
    
    private let service:Service
    
    init?(url:String,header:[String:String]) {
        guard let baseURL = URL(string: url) else { return nil }
        self.service = Service(baseURL: baseURL, baseHeader: header)
    }
    public func request<T:Requestable>(object:T,completionHandler: @escaping (Result<T.ResponseType?,ServiceError>) -> Void) {
        service.request(object: object) { (response) in
            switch response {
            case .failure(let error):
                guard let error = error as? ServiceError else { break }
                switch error {
                case .badHttpStatus(let status, let message):
                    print(status,message!)
                default:
                    print(error)
                }
            case .success(let success):
                completionHandler(.success(success))
            }
        }
    }
    
    private func refreshToken<T:Requestable>(object:T,completionHandler: @escaping (Result<T,Error>) -> Void) {
        
    }
}
