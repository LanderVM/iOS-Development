//
//  ParkingModel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 20/12/2023.
//

import Foundation

struct ParkingModel {
    private(set) var parkings: Array<ParkingInfo>
    
    init(_ parkings: Array<ParkingInfo>) {
        self.parkings = parkings
    }
    
    struct ParkingInfo {
        let name: String
        let description: String
        let occupation: Int
        let totalCapacity: Int
        
        func navigateToAbout() {
                print("Selected parking: \(name)")
        }
    }
}
