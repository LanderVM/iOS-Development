//
//  ParkingViewmodel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 21/12/2023.
//

import SwiftUI

class ParkingViewModel: ObservableObject {
    private static let parkingInfoArray = [
        (name: "Vrijdagmarkt", description: "Ondergrondse parkeergarage Vrijdagmarkt in Gent", availableSpaces: 354, totalCapacity: 595),
        (name: "Savaanstraat", description: "Ondergrondse parkeergarage Savaanstraat in Gent", availableSpaces: 464, totalCapacity: 530),
        (name: "Ledeberg", description: "Bovengrondse parkeergarage Ledeberg in Gent", availableSpaces: 32, totalCapacity: 495),
        (name: "B-Park Gent Sint-Pieters", description: "Ondergrondse parkeergarage NMBS Gent-Sint-Pieters in Gent", availableSpaces: 47, totalCapacity: 500),
        (name: "Sint-Michiels", description: "Ondergrondse parkeergarage Sint-Michiels in Gent", availableSpaces: 225, totalCapacity: 446),
        (name: "Reep", description: "? parkeergarage Reep in Gent", availableSpaces: 83, totalCapacity: 449),
        (name: "Ramen", description: "Ondergrondse parkeergarage Ramen in Gent", availableSpaces: 80, totalCapacity: 250),
        (name: "Tolhuis", description: "Ondergrondse parkeergarage Tolhuis in Gent", availableSpaces: 61, totalCapacity: 150),
        (name: "Sint-Pietersplein", description: "? parkeergarage Sint-Pietersplein in Gent", availableSpaces: 59, totalCapacity: 683),
        (name: "Getouw", description: "Bovengrondse parkeergarage Het Getouw in Gent", availableSpaces: 2, totalCapacity: 350)
    ]
    
    private static func createParkingModel() -> ParkingModel {
        return ParkingModel(parkingInfoArray.map {
            ParkingModel.ParkingInfo(
                name: $0.name,
                description: $0.description,
                availableSpaces: $0.availableSpaces,
                totalCapacity: $0.totalCapacity
            )
        })
    }
    
    @Published private var model = createParkingModel()
    
    var parkings: Array<ParkingModel.ParkingInfo> {
        return model.parkings
    }
    
    func filteredParkings() -> [ParkingModel.ParkingInfo] {
        switch model.filterOption {
        case .name:
            print("Sort by name")
            return model.parkings.sorted(by: { $0.name < $1.name })
        case .freeSpaces:
            print("Sort by freespace")
            return model.parkings.sorted(by: { $0.availableSpaces > $1.availableSpaces })
        }
    }
    
    func setFilterOption(_ option: FilterOption) {
        print("Setting filter option to \(option)")
        model.filterOption = option
    }

}

enum FilterOption {
    case name
    case freeSpaces
}

