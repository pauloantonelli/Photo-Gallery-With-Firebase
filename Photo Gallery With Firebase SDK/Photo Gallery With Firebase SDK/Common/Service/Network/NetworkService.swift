//
//  Network.swift
//  Photo Gallery With Firebase SDK
//
//  Created by Paulo Antonelli on 25/10/22.
//

import Foundation

class NetworkService: INetworkService {
    var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func get(url: String) async -> (Data, HTTPURLResponse) {
        let url: URL = URL(string: "\(baseUrl)\(url)")!
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            self.debugHttpStatusLog(withURLResponse: response)
            return (data, response as! HTTPURLResponse)
//            let decodeData = try self.jsonDecoderFactory().decode(T.self, from: data)
//            return decodeData
        } catch {
            fatalError("Error on Network on get: \(error.localizedDescription)")
        }
    }
    
    func post(url: String, withBody body: [String : AnyHashable]) async -> (Data, HTTPURLResponse) {
        let url: URL = URL(string: "\(baseUrl)\(url)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = self.httpBodySerializationFactory(withBody: body)
            let (data, response) = try await URLSession.shared.data(for: request)
            self.debugHttpStatusLog(withURLResponse: response)
            return (data, response as! HTTPURLResponse)
//            let decodeData = try self.jsonDecoderFactory().decode(T.self, from: data)
//            return decodeData
        } catch {
            fatalError("Error on Network on post: \(error.localizedDescription)")
        }
    }
    
    func put(url: String, withBody body: [String : AnyHashable]) async -> (Data, HTTPURLResponse) {
        let url: URL = URL(string: "\(baseUrl)\(url)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = self.httpBodySerializationFactory(withBody: body)
            let (data, response) = try await URLSession.shared.data(for: request)
            self.debugHttpStatusLog(withURLResponse: response)
            return (data, response as! HTTPURLResponse)
//            let decodeData = try self.jsonDecoderFactory().decode(T.self, from: data)
//            return decodeData
        } catch {
            fatalError("Error on Network on put: \(error.localizedDescription)")
        }
    }
    
    func delete(url: String, withBody body: [String : AnyHashable]?) async -> (Data, HTTPURLResponse) {
        let url: URL = URL(string: "\(baseUrl)\(url)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            if let safeBody = body {
                request.httpBody = self.httpBodySerializationFactory(withBody: safeBody)
            }
            let (data, response) = try await URLSession.shared.data(for: request)
            self.debugHttpStatusLog(withURLResponse: response)
            return (data, response as! HTTPURLResponse)
//            let decodeData = try self.jsonDecoderFactory().decode(T.self, from: data)
//            return decodeData
        } catch {
            fatalError("Error on Network on delete: \(error.localizedDescription)")
        }
    }
}

extension NetworkService {
    fileprivate func jsonDecoderFactory() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    fileprivate func jsonEncoderFactory() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
    
    fileprivate func httpBodySerializationFactory(withBody body: [String : AnyHashable]) -> Data? {
        do {
            let result = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
            return result
        } catch {
            fatalError("Error on Network on http body serialization factory: \(error.localizedDescription)")
        }
    }
    
    fileprivate func debugHttpStatusLog(withURLResponse response: URLResponse) {
        guard let safeResponse = (response as? HTTPURLResponse) else {
            fatalError("Error on HttpResponse")
        }
        print("URL: \(String(describing: safeResponse.url)) - Status \(safeResponse.statusCode)")
    }
}
