import Foundation

// Basic Swift Codablity serialzation

public struct MyType: Codable {

    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case date = "todays_date"
        case address = "your_address"
    }

    // Adding the memberwise init that is missing when explicitly conforming to Codability
    public init(name: String, date: Date, address: String) {
        self.name = name
        self.date = date
        self.address = address
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(Date.self, forKey: .date)
        address = try container.decode(String.self, forKey: .address)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(address, forKey: .address)
    }
    
    public let name: String
    public let date: Date
    public let address: String
    
    public static func justinType() -> MyType {
        return MyType(name: "Justin", date: Date(), address: "1600 Pensilvania ave")
    }
}
