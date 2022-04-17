//
//  JSEventObj.swift
//  SecureMe
//
//  Created by Benny Davidovitz on 07/04/2021.
//

import Foundation

struct JSEventObj: Codable {
    enum EventType: String {
        case loaded = "Application-state: loaded"
        case success = "Success"
        case error = "Error"
    }
    
    struct Payload: Codable {
        let value: String?
    }
    
    let authorizationToken: String?
    let customerInternalReference: String?
    let dateTime: String?
    let eventType: String?
    let payload: Payload?
    let transactionReference: String?
    
    var event: EventType? {
        guard let eventType = eventType else { return nil }
        return EventType(rawValue: eventType)
    }
    
    init?(body: Any?) {
        guard
            let string = body as? String,
            let data = string.data(using: .utf8),
            let obj = try? JSONDecoder().decode(JSEventObj.self, from: data)
        else {
            return nil
        }
        self = obj
    }
}
