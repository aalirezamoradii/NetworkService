//
//  Setting.swift
//  NetworkService
//
//  Created by Alireza Moradi on 05/27/2020.
//  Copyright © 2020 Alireza Moradi. All rights reserved.
//

import Foundation

public class BaseNetwork {
    
    let url: URL
    let encoder: JSONEncoder
    let decoder: JSONDecoder
    let header: [String:String]
    let session: URLSession
    let semaphore: DispatchSemaphore
    let operation: OperationQueue
    
    typealias errorType<T> = T where T : Decodable
    
    public init(baseURL:URL, header:[String:String], queue:DispatchQueue, semaphoreValue: Int) {
        self.url = baseURL
        self.header = header
        semaphore = DispatchSemaphore(value: semaphoreValue)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dataDecodingStrategy = .base64
        decoder = jsonDecoder
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = []
        jsonEncoder.dataEncodingStrategy = .base64
        encoder = jsonEncoder
        let config = URLSessionConfiguration.default
        config.httpShouldSetCookies = false
        config.httpCookieAcceptPolicy = .never
        config.networkServiceType = .responsiveData
        config.shouldUseExtendedBackgroundIdleMode = true
        session = URLSession(configuration: config, delegate: nil, delegateQueue: .main)
        let operation = OperationQueue()
        operation.qualityOfService = QualityOfService(rawValue: queue.qos.relativePriority) ?? .default
        operation.underlyingQueue = queue
        self.operation = operation
    }
    
    func decode<T>(_: T.Type, from data: Data) throws -> T where T : Decodable {
        try decoder.decode(T.self, from: data)
    }
    
    func encode<T>(_ data: T) throws -> Data where T : Encodable {
        try encoder.encode(data)
    }
    
}
