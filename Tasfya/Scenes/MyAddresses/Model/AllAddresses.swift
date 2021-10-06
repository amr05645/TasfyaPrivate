//
//  AllAddresses.swift
//  Tasfya
//
//  Created by BMS on 03/10/2021.
//



import Foundation

// MARK: - Welcome
struct AllAddresses: Codable {
    var success: String?
    var data: [AddressesData]?
    var message: String?
}

// MARK: - Datum
struct AddressesData: Codable {
    var addressID: String?
    var gender: String?
    var company, firstname, lastname, street: String?
    var suburb, postcode, city, state: String?
    var countriesID, countryName, zoneID, zoneCode: String?
    var zoneName: String?
    var defaultAddress: String?

    enum CodingKeys: String, CodingKey {
        case addressID = "address_id"
        case gender, company, firstname, lastname, street, suburb, postcode, city, state
        case countriesID = "countries_id"
        case countryName = "country_name"
        case zoneID = "zone_id"
        case zoneCode = "zone_code"
        case zoneName = "zone_name"
        case defaultAddress = "default_address"
    }
}

