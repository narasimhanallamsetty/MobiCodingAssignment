//
//  Repository.swift
//  MobiCodingChallenge
//
//  Created by Narasimha Nallamsetty on 19/07/24.
//

import Foundation

//Created struct for data Model
struct Repository: Decodable {
    let id: Int
    let name: String
    let stargazers_count: Int
}

