//
//  MainScreenModel.swift
//  Tasfya
//
//  Created by Amr on 02/09/2021.
//

import Foundation

// MARK: - Welcome
struct GetBanners: Codable {
    var success: String?
    var data: [BannerData]?
    var message: String?
}

// MARK: - Datum
struct BannerData: Codable {
    var id, title, url, image: String?
    var type: String?
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - Welcome
struct AllProducts: Codable {
    var success: String?
    var productData: [ProductData]?
    var message: String?
    var totalRecord: Int?

    enum CodingKeys: String, CodingKey {
        case success
        case productData = "product_data"
        case message
        case totalRecord = "total_record"
    }
}

// MARK: - ProductDatum
struct ProductData: Codable {
    var productsID, productsQuantity, productsModel, productsImage: String?
    var productsPrice, productsDateAdded: String?
    var productsLastModified: String?
    var productsDateAvailable: JSONNull?
    var productsWeight: String?
    var productsWeightUnit: ProductsWeightUnit?
    var productsStatus, productsTaxClassID: String?
    var manufacturersID: String?
    var productsOrdered, productsLiked, lowLimit, languageID: String?
    var productsName, productsDescription: String?
    var productsURL: JSONNull?
    var productsViewed: String?
    var manufacturersName, manufacturersImage, dateAdded: String?
    var lastModified: JSONNull?
    var manufacturersURL, discountPrice: String?
    var categoriesID, categoriesDescriptionID: String?
    var categoriesName: String?
    var images: [Image]?
    var isLiked: String?
    var attributes: [Attribute]?

    enum CodingKeys: String, CodingKey {
        case productsID = "products_id"
        case productsQuantity = "products_quantity"
        case productsModel = "products_model"
        case productsImage = "products_image"
        case productsPrice = "products_price"
        case productsDateAdded = "products_date_added"
        case productsLastModified = "products_last_modified"
        case productsDateAvailable = "products_date_available"
        case productsWeight = "products_weight"
        case productsWeightUnit = "products_weight_unit"
        case productsStatus = "products_status"
        case productsTaxClassID = "products_tax_class_id"
        case manufacturersID = "manufacturers_id"
        case productsOrdered = "products_ordered"
        case productsLiked = "products_liked"
        case lowLimit = "low_limit"
        case languageID = "language_id"
        case productsName = "products_name"
        case productsDescription = "products_description"
        case productsURL = "products_url"
        case productsViewed = "products_viewed"
        case manufacturersName = "manufacturers_name"
        case manufacturersImage = "manufacturers_image"
        case dateAdded = "date_added"
        case lastModified = "last_modified"
        case manufacturersURL = "manufacturers_url"
        case discountPrice = "discount_price"
        case categoriesID = "categories_id"
        case categoriesDescriptionID = "categories_description_id"
        case categoriesName = "categories_name"
        case images, isLiked, attributes
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    var option: Option?
    var values: [Value]?
}

// MARK: - Option
struct Option: Codable {
    var id, name: String?
}

// MARK: - Value
struct Value: Codable {
    var id, value, price, pricePrefix: String?

    enum CodingKeys: String, CodingKey {
        case id, value, price
        case pricePrefix = "price_prefix"
    }
}

// MARK: - Image
struct Image: Codable {
    var image: String?
}

enum ProductsWeightUnit: String, Codable {
    case g = "g"
    case kg = "kg"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

