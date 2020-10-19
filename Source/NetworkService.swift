//
//  NetworkService.swift
//  NetworkService
//
//  Created by Alireza Moradi on 2/17/20.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public class NetworkService  {
    
    private let base: BaseNetwork
    
    public typealias handler<T> = (Result<T.ResponseType?,Error>) -> Void where T : Requestable
    
    public init(base: BaseNetwork) {
        self.base = base
    }
    
    public func request<T>(object:T, completion: @escaping handler<T>) where T : Requestable {
        operation.addOperation { [self] in
            do {
                let request = try requestHandler(object: object)
                task(request, obejct: object, completion: completion)
            } catch {
                completion(.failure(ServiceError<T>.failure(error)))
            }
        }
    }
    
    private func requestHandler<T>(object:T) throws -> URLRequest where T : Requestable {
        
        guard let url = URL(string: type(of: object).url, relativeTo: base.url) else { throw ServiceError<T.ResponseError>.invalidURL }
        
        var request = URLRequest(url: url)
        
        switch type(of: object).requestType {
        
        case .jsonBody:
            request.httpBody = try base.encode(object)
            
        case .urlQuery:
            request = try query(url: url, parameters: object)
            
        default:
            break
        }
        
        var header = object.dictionary
        header.merge(base.header)
        
        request.allHTTPHeaderFields = header
        request.httpMethod = type(of: object).method.rawValue
        
        return request
    }
    private func query<T>(url:URL, parameters:T) throws -> URLRequest where T : Requestable {
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw ServiceError<T.ResponseError>.invalidURL }
        
        components.queryItems(with: parameters.dictionary)
        
        guard let componentUrl = components.url else { throw ServiceError<T.ResponseError>.invalidURL }
        
        return URLRequest(url: componentUrl)
    }
    
    private func response<T>(obejct:T.Type, response:HTTPURLResponse?, data:Data?) throws -> Data where T : Decodable {
                
        guard let response = response else { throw ServiceError<T>.invalidResponse }
        
        switch response.statusCode {
        
        case 200...208:
            return data ?? Data()
            
        case 401:
            guard let data = data else { throw ServiceError<T>.invalidData }
            
            let error = try base.decode(T.self, from: data)
                        
            if let error = error as? ErrorType<T> {
                throw ServiceError<T>.loginFaild(error.title)
            } else {
                throw ServiceError.error(error)
            }
            
        case 400,402...499:
            guard let data = data else { throw ServiceError<T>.invalidData }
            
            let error = try base.decode(T.self, from: data)
                        
            if let error = error as? ErrorType<T> {
                throw ServiceError<T>.badHttpStatus(response.statusCode, error.errors, error.title)
            } else {
                throw ServiceError.error(error)
            }
            
        case 500...:
            throw ServiceError<T>.invalidServer
            
        default:
            throw ServiceError<T>.timeOut
        }
    }
    
    private func task<T>(_ request: URLRequest, obejct:T, completion: @escaping handler<T>) where T : Requestable
    {
        base.session.dataTask(with: request) { [self] (data, responses, error) in
            do {
                if let error = error { throw error }
                let data = try response(obejct:T.ResponseError.self, response: responses as? HTTPURLResponse, data: data)
                let result = data.isEmpty
                    ? nil
                    : try base.decode(T.ResponseType.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ServiceError<T>.failure(error)))
            }
        }.resume()
    }
}

extension NetworkService {
    
    private var operation: OperationQueue {
        base.operation
    }
    private var semaphore: DispatchSemaphore {
        base.semaphore
    }
    private func signal() {
        semaphore.signal()
    }
    private func wait() {
        semaphore.wait()
    }
}
