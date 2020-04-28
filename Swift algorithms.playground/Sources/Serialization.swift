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
    
    // Encoding to JSON
    public func jsonEncode() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
    
    // Decoding from JSON
    public static func jsonDecode(data: Data) throws -> MyType {
        let decoder = JSONDecoder()
        return try decoder.decode(MyType.self, from: data)
    }
    
    // Encoding to Plist
    public func xmlPlistEncode() throws -> Data {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        return try encoder.encode(self)
    }
    
    public static func xmlPlistDecoder(data: Data) throws -> MyType {
        let decoder = PropertyListDecoder()
        return try decoder.decode(MyType.self, from: data)
    }
}


// Using Serialization for polymorphisum

public protocol Length {}
public struct Feet: Length {}
public struct Meters: Length {}

public struct Distance<Units: Length>: Codable, Equatable, ExpressibleByFloatLiteral {
    var value: Double

    static var unitType: String {
        String(describing: Units.self).lowercased()
    }

    struct UnitsKey: CodingKey {
        var stringValue: String

        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? { fatalError() }

        init?(intValue: Int) { fatalError() }
    }

    public init(floatLiteral value: FloatLiteralType) {
        self.value = value
    }

    public init(from decoder: Decoder) throws {
        let continer = try decoder.container(keyedBy: UnitsKey.self)
        self.value = try continer.decode(Double.self, forKey: UnitsKey(stringValue: Distance.unitType)!)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UnitsKey.self)
        try container.encode(value, forKey: UnitsKey(stringValue: Distance.unitType)!)
    }
}
