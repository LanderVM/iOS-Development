//
//  ParkingModel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 20/12/2023.
//

import Foundation

struct ParkingModel {
    private(set) var parkings: [ParkingInfo]
    var filterOption: FilterOption = .name
    
    init(_ parkings: [ParkingInfo]) {
        self.parkings = parkings
    }
    
    struct ParkingInfo {
        let name: String
        let description: String
        let availableSpaces: Int
        let totalCapacity: Int
        let lastUpdate: String
        let isOpenNow: Bool
        let urlLinkAddress: String
        let location: Location

        struct Location {
            let latitude: Double
            let longitude: Double
        }

        func navigateToAbout() {
            print("Selected parking: \(name)")
        }
    }
}
