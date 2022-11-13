import Foundation

//MARK: JSON Model

struct DataModel: Codable {
    let info:    Info
    let results: [Result]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next:  String
}

struct Result: Codable {
    let id:       Int
    let name:     String
    let status:   Status
    let species:  Species
    let type:     String
    let gender:   Gender
    let origin:   Location
    let location: Location
    let image:    String
    let episode:  [String]
    let url:      String
    let created:  String
}

enum Gender: String, Codable {
    case female  = "Female"
    case male    = "Male"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String
    let url:  String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive   = "Alive"
    case dead    = "Dead"
    case unknown = "unknown"
}
