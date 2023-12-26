//
//  ParkingModel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 20/12/2023.
//

import Foundation

struct ParkingModel: Codable {
    private(set) var parkings: [ParkingInfo]
    var filterOption: FilterOption = .name
    
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        print("ParkingGent = \(String(data: encoded, encoding: .utf8) ?? "nil")")
        return encoded
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode(ParkingModel.self, from: json)
    }
    
    init(_ parkings: [ParkingInfo]) {
        self.parkings = parkings
    }
    
    struct ParkingInfo: Codable {
        let name: String
        let description: String
        let availableSpaces: Int
        let totalCapacity: Int
        let lastUpdate: String
        let isOpenNow: Bool
        let urlLinkAddress: String
        let location: Location

        struct Location: Codable {
            let latitude: Double
            let longitude: Double
        }

        func navigateToAbout() {
            print("Selected parking: \(name)")
        }
    }
}
