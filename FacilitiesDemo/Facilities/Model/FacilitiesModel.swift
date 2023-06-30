// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let facilitiesModel = try? JSONDecoder().decode(FacilitiesModel.self, from: jsonData)

import Foundation

// MARK: - FacilitiesModel
struct FacilitiesModel: Codable {
    var facilities: [Facility]?
    let exclusions: [[Exclusion]]?
}

// MARK: - Exclusion
struct Exclusion: Codable {
    let facilityID, optionsID: String?

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}

// MARK: - Facility
struct Facility: Codable {
    let facilityID, name: String?
    var options: [Option]?

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}

// MARK: - Option
struct Option: Codable {
    let name, icon, id: String?
    var isSelected : Bool? = false
    var isDisabled : Bool? = false
}

struct sortedExclusions {
    var onFacility_id : String
    var disableForOptionId : String
    var options_id : String
}
