//
//  ParkingModel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 20/12/2023.
//

import Foundation

struct ParkingModel {
    private(set) var parkings: Array<ParkingInfo>
    var filterOption: FilterOption = .name
    
    init(_ parkings: Array<ParkingInfo>) {
        self.parkings = parkings
    }
    
    struct ParkingInfo {
        let name: String
        let description: String
        let availableSpaces: Int
        let totalCapacity: Int
        
        func navigateToAbout() {
            print("Selected parking: \(name)")
        }
    }
}
