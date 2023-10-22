//
//  DallEResponse.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 16.10.2023.
//
import Foundation

struct DallE: Decodable {
    let data: [ImageURL]
}

struct ImageUrl: Decodable {
    let url: String
}
