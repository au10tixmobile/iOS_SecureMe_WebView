//
//  JSEventObj.swift
//  SecureMe
//
//  Created by Benny Davidovitz on 07/04/2021.
//

import Foundation

struct JSEventObj: Codable {
    struct Payload: Codable {
        let value: String
    }
    
    let authorizationToken: String
    let customerInternalReference: String
    let dateTime: String
    let eventType: String
    let payload: Payload
    let transactionReference: String
    
    init?(dict: [String:Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .init()) else {
            return nil
        }
        
        guard let obj = try? JSONDecoder().decode(JSEventObj.self, from: data) else {
            return nil
        }
        
        self = obj
    }
}
