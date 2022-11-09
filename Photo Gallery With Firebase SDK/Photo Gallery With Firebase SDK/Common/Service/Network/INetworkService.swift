//
//  INetwork.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 03/11/22.
//

import Foundation

protocol INetworkService {
    var baseUrl: String { get set }
    
    func get(url: String) async -> (Data, HTTPURLResponse)
    func post(url: String, withBody body: [String : AnyHashable]) async -> (Data, HTTPURLResponse)
    func put(url: String, withBody body: [String : AnyHashable]) async -> (Data, HTTPURLResponse)
    func delete(url: String, withBody body: [String : AnyHashable]?) async -> (Data, HTTPURLResponse)
}
