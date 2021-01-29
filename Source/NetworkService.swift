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
                completion(.failure(error))
            }
        }
    }
    
    private func requestHandler<T>(object: T) throws -> URLRequest where T : Requestable {
        
        guard let url = URL(string: type(of: object).url, relativeTo: base.url) else { throw NTSError.invalidURL }
        
        var request = URLRequest(url: url)
        
        switch type(of: object).requestType {
        
        case .jsonBody:
            request.httpBody = try base.encode(object)
            
        case .urlQuery:
            request.url = try query(url: url, parameters: object)
            
        default:
            break
        }
        
        var header = type(of: object).header
        header.merge(base.header)
        
        request.allHTTPHeaderFields = header
        request.httpMethod = type(of: object).method.rawValue
        
        return request
    }
    private func query<T>(url:URL, parameters:T) throws -> URL where T : Requestable {
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { throw NTSError.invalidURL }
        
        components.queryItems(with: parameters.anyDictionary)
        
        guard let componentUrl = components.url else { throw NTSError.invalidURL }
        
        return componentUrl
    }
    
    private func response<T>(obejct:T.Type, response:HTTPURLResponse?, data:Data?) throws -> Data where T : Decodable {
                
        guard let response = response else { throw NTSError.invalidResponse }
        
        guard let data = data else { throw NTSError.invalidData }
        
        let error = try? base.decode(T.self, from: data)
        
        switch response.statusCode {
        case 200...208:
            return data
        
        case 401:
            throw NTSError.loginFaild(error)
            
        case 400...499:
            throw NTSError.badHttp(error)
            
        case 500...:
            throw NTSError.invalidServer
            
        default:
            throw NTSError.unknown
        }
    }
    
    private func task<T>(_ request: URLRequest, obejct:T, completion: @escaping handler<T>) where T : Requestable
    {
        let task = base.session.dataTask(with: request) { [self] (data, responses, error) in
            do {
                if let error = error { throw error }
                let data = try response(obejct:T.ResponseError.self, response: responses as? HTTPURLResponse, data: data)
                let result = data.isEmpty
                    ? nil
                    : try base.decode(T.ResponseType.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
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
