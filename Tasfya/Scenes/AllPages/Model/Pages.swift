
import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)


// MARK: - Welcome
struct Pages: Codable {
    var success: String?
    var pagesData: [PagesData]?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case success
        case pagesData = "pages_data"
        case message
    }
}

// MARK: - PagesDatum
struct PagesData: Codable {
    var pageID, slug, status, pageDescriptionID: String?
    var name, pagesDatumDescription, languageID: String?

    enum CodingKeys: String, CodingKey {
        case pageID = "page_id"
        case slug, status
        case pageDescriptionID = "page_description_id"
        case name
        case pagesDatumDescription = "description"
        case languageID = "language_id"
    }
}
