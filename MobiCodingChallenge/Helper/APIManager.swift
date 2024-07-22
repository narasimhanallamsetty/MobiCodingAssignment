//
//  APIManager.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 19/07/24.
//

import Foundation
import UIKit

//Adding an enum for understanding error message properly whether URL is invalid or decoding issue etc.
enum dataError:Error {
case invalidReponse
    case invalidURL
    case invalidDecoding
    case invalidData
    case message(_error:Error?)
}

//through this handler we can send data or error
typealias Handler = (Result<[Repository],dataError>) ->Void
//singleton design pattern
final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () {
        
    }
    //API call to fetch repositories data. Sending here page number also for pagination handling. Based on page number it will fetch the data.
    func fetchRepositories(page: Int,completion: @escaping Handler) {
        guard let url = URL(string: "\(Constant.baseURL)?page=\(page)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response,error in
            guard let data, error == nil else {
                //if the data is invalid we will send invalid data
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                //if the response is not valid then we will send invalid response
                completion(.failure(.invalidReponse))
                return
            }
            
            do {
                //used JsonDecoder for parsing the data.
                let products = try JSONDecoder().decode([Repository].self, from: data)
                debugPrint("...\(products)")
                completion(.success(products)) //sending data through completion handler
            } catch {
                print(error.localizedDescription)
                completion(.failure(.message(_error: error))) ////sending error message
            }
        }.resume()
    }
}



