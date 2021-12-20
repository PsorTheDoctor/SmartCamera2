//
//  Item.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 19/12/2021.
//

struct Item: Decodable, Hashable {
    let title: String
    let primaryImageSmall: String
    let artistDisplayName: String
    let creditLine: String
    
    enum codingKeys: String, CodingKey {
        case title
        case primaryImageSmall
        case artistDisplayName
        case creditLine
    }
}
