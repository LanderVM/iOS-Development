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
        let lastUpdate: String
        let totalCapacity: Int
        let availableCapacity: Int
        let occupation: Int
        let type: String
        let description: String
        let id: String
        let openingtimesDescription: String
        let isOpenNow: Bool
        let temporaryClosed: Bool
        let operatorInformation: String
        let isFreeParking: Bool
        let urlLinkAddress: String
        let locationAndDimension: String
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
