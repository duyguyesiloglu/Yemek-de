//
//  GPTResponse.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 16.10.2023.
//

import Foundation

struct GPTResponse: Decodable {
    let choices: [GPTCompletion]
}
struct GPTCompletion: Decodable {
    let text: String
    let finishReason: String
}

