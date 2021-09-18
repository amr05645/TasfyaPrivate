//
//  LikesModel.swift
//  Tasfya
//
//  Created by Amr on 16/09/2021.
//

import Foundation

// MARK: - Welcome
struct LikesModel: Codable {
    var success: String?
    var productData: [LikesData]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case success
        case productData = "product_data"
        case message
    }
}

// MARK: - ProductDatum
struct LikesData: Codable {
    var likedProductsID: String?

    enum CodingKeys: String, CodingKey {
        case likedProductsID = "liked_products_id"
    }
}
