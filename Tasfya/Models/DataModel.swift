//
//  DataModel.swift
//  Tasfya
//
//  Created by Amr on 02/08/2021.
//

import Foundation

struct Product: Decodable{
    
    let id: Int?
    let title: String?
    let price: Double?
    let category: String?
    let description: String?
    let image: String?
    
}
