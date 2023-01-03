//
//  suggestionCompletion.swift
//  Stock Market
//
//  Created by 李炘杰 on 2023/1/4.
//

import Foundation

struct BestMatch: Codable{
    let bestMatchs: [bestMatch]
    
    enum CodingKeys: String, CodingKey {
        case bestMatchs = "bestMatches"
    }
}

struct bestMatch: Codable , Hashable{
    let symbol: String
    let name: String
    let type: String
    let region: String
    let marketOpen: String
    let marketClose: String
    let timezone: String
    let currency: String
    let mathScore: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case type = "3. type"
        case region = "4. region"
        case marketOpen = "5. marketOpen"
        case marketClose = "6. marketClose"
        case timezone = "7. timezone"
        case currency = "8. currency"
        case mathScore = "9. matchScore"
    }
}






