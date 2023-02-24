//
//  NetworkModel.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import Foundation

//CREMOA NUESTROS ERROR
enum NetworkError: Error, Equatable {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(code: Int?)
    case tokenFormatError
    case decoding
    case unknown
    case decodingFailed
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkModel {
    
    let session : URLSession
    var token: String?
    
    init(urlSession: URLSession = .shared, token: String? = nil) {
        self.session = urlSession
        self.token = token
    }
    
    func login(user: String, password: String, completion: @escaping (String?, NetworkError?) -> Void) {
        
        guard let url = URL (string: "https://dragonball.keepcoding.education/api/auth/login") else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(nil, NetworkError.dataFormatting)
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil
            else {
                completion(nil, NetworkError.other)
                return
            }
            
            guard let data = data
            else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200
            else {
                completion(nil, NetworkError.errorCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8)
            else {
                completion(nil, NetworkError.tokenFormatError)
                return
            }
            
            completion(token, nil)
        }
        task.resume()
    }
    
    func getHeroes(name: String = "", completion: @escaping ([Hero], NetworkError?) -> Void) {
        
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/heros/all") else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        guard let token = self.token else {
            completion([], NetworkError.other)
            return
        }
        
        struct Body: Encodable {
            let name: String
        }
        let body = Body(name: name)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil
            else {
                completion([], NetworkError.other)
                return
            }
            
            guard let data = data
            else {
                completion([], NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200
            else {
                completion([], NetworkError.errorCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                completion([], NetworkError.decoding)
                return
            }
            
            completion(heroesResponse, nil)
        }
        task.resume()
    }
    
    func getLocalizacionHeroes(id: String, completion: @escaping ([HeroCoordenates], NetworkError?) -> Void) {
        guard let url = URL(string: "https://dragonball.keepcoding.education/api/heros/locations")
        else {
            completion([], NetworkError.malformedURL)
            return
        }
        
        guard let token = self.token else {
            completion([], NetworkError.tokenFormatError)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        struct Body: Encodable {
            let id: String
        }
        let body = Body(id: id)
        
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil
            else {
                completion([], NetworkError.other)
                return
            }
            
            guard let data = data
            else {
                completion([], NetworkError.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == 200
            else {
                completion([], NetworkError.errorCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let response = try? JSONDecoder().decode([HeroCoordenates].self, from: data) else {
                completion([], NetworkError.decodingFailed)
                return
            }
            completion(response, nil)
        }
        task.resume()
    }
}


