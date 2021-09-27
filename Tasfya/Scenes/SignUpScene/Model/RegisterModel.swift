////

import Foundation

// MARK: - Welcome
struct Register: Codable {
    let success: String
    let data: [regData]
    let message: String
}

// MARK: - Datum
struct regData: Codable {
    let customersID, customersGender, customersFirstname, customersLastname: String
    let customersDob, customersEmailAddress, userName: String
   // let customersDefaultAddressID: JSONNull?
    let customersTelephone: String
    //let customersFax: JSONNull?
    let customersPassword: String
   // let customersNewsletter: JSONNull?
    let isActive: String
    //let fbID, googleID: JSONNull?
    let customersPicture, createdAt, updatedAt, isSeen: String

    enum CodingKeys: String, CodingKey {
        case customersID = "customers_id"
        case customersGender = "customers_gender"
        case customersFirstname = "customers_firstname"
        case customersLastname = "customers_lastname"
        case customersDob = "customers_dob"
        case customersEmailAddress = "customers_email_address"
        case userName = "user_name"
       // case customersDefaultAddressID = "customers_default_address_id"
        case customersTelephone = "customers_telephone"
        //case customersFax = "customers_fax"
        case customersPassword = "customers_password"
        //case customersNewsletter = "customers_newsletter"
        case isActive
       // case fbID = "fb_id"
      //  case googleID = "google_id"
        case customersPicture = "customers_picture"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isSeen = "is_seen"
    }
}


