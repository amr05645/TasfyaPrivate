//
//  Login.swift
//  Tasfya
//
//  Created by BMS on 27/09/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Login: Codable {
    let success: String
    let data: [loginData]
    let message: String
}

// MARK: - Datum
struct loginData: Codable {
    let customersID, customersGender, customersFirstname, customersLastname: String
    let customersDob, customersEmailAddress, userName, customersDefaultAddressID: String
    let customersTelephone: String
    let customersFax: JSONNull?
    let customersPassword: String
    let customersNewsletter: JSONNull?
    let isActive: String
    let fbID, googleID: JSONNull?
    let customersPicture, createdAt, updatedAt, isSeen: String
    let likedProducts: [LikedProduct]

    enum CodingKeys: String, CodingKey {
        case customersID = "customers_id"
        case customersGender = "customers_gender"
        case customersFirstname = "customers_firstname"
        case customersLastname = "customers_lastname"
        case customersDob = "customers_dob"
        case customersEmailAddress = "customers_email_address"
        case userName = "user_name"
        case customersDefaultAddressID = "customers_default_address_id"
        case customersTelephone = "customers_telephone"
        case customersFax = "customers_fax"
        case customersPassword = "customers_password"
        case customersNewsletter = "customers_newsletter"
        case isActive
        case fbID = "fb_id"
        case googleID = "google_id"
        case customersPicture = "customers_picture"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isSeen = "is_seen"
        case likedProducts = "liked_products"
    }
}

// MARK: - LikedProduct
struct LikedProduct: Codable {
    let productsID: String

    enum CodingKeys: String, CodingKey {
        case productsID = "products_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
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
