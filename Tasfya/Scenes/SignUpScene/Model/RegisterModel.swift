//
//  RegisterModel.swift
//  Tasfya
//
//  Created by Amr on 19/09/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Register: Codable {
    var success: String?
    var data: [RegData]?
    var message: String?
}

// MARK: - Datum
struct RegData: Codable {
    var customersID, customersGender, customersFirstname, customersLastname: String?
    var customersDob, customersEmailAddress, userName: String?
    var customersDefaultAddressID: String?
    var customersTelephone: String?
    var customersFax: String?
    var customersPassword: String?
    var customersNewsletter: String?
    var isActive: String?
    var fbID, googleID: String?
    var customersPicture, createdAt, updatedAt, isSeen: String?

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
    }
}
