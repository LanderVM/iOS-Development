//
//  ParkingViewmodel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 21/12/2023.
//

import SwiftUI

class ParkingViewModel: ObservableObject {
    private static let parkingInfoArray = [
        (name: "Vrijdagmarkt", description: "Ondergrondse parkeergarage Vrijdagmarkt in Gent", occupation: 94, totalCapacity: 595),
        (name: "Savaanstraat", description: "Ondergrondse parkeergarage Savaanstraat in Gent", occupation: 64, totalCapacity: 530),
        (name: "Ledeberg", description: "Bovengrondse parkeergarage Ledeberg in Gent", occupation: 32, totalCapacity: 495),
        (name: "B-Park Gent Sint-Pieters", description: "Ondergrondse parkeergarage NMBS Gent-Sint-Pieters in Gent", occupation: 47, totalCapacity: 500),
        (name: "Sint-Michiels", description: "Ondergrondse parkeergarage Sint-Michiels in Gent", occupation: 75, totalCapacity: 446),
        (name: "Reep", description: "? parkeergarage Reep in Gent", occupation: 83, totalCapacity: 449),
        (name: "Ramen", description: "Ondergrondse parkeergarage Ramen in Gent", occupation: 80, totalCapacity: 250),
        (name: "Tolhuis", description: "Ondergrondse parkeergarage Tolhuis in Gent", occupation: 61, totalCapacity: 150),
        (name: "Sint-Pietersplein", description: "? parkeergarage Sint-Pietersplein in Gent", occupation: 59, totalCapacity: 683),
        (name: "Getouw", description: "Bovengrondse parkeergarage Het Getouw in Gent", occupation: 2, totalCapacity: 350)
    ]
    
    private static func createParkingModel() -> ParkingModel {
        return ParkingModel(parkingInfoArray.map {
            ParkingModel.ParkingInfo(
                name: $0.name,
                description: $0.description,
                occupation: $0.occupation,
                totalCapacity: $0.totalCapacity
            )
        })
    }
    
    @Published private var model = createParkingModel()
    
    var parkings: Array<ParkingModel.ParkingInfo> {
        return model.parkings
    }
}


