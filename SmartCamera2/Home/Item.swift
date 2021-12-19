//
//  Item.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 19/12/2021.
//

struct Item: Decodable {
    let title: String
    let primaryImageSmall: String
    
    enum codingKeys: String, CodingKey {
        case title = "title"
        case primaryImageSmall
    }
}
