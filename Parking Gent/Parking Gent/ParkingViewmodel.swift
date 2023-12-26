//
//  ParkingViewmodel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 21/12/2023.
//

import SwiftUI

class ParkingViewModel: ObservableObject {
    @Published private var model: ParkingModel
    private let apiService: ParkingAPIService

    init(apiService: ParkingAPIService = ParkingAPIService()) {
        self.apiService = apiService
        self.model = ParkingModel([])
        fetchParkingData()
    }

    func fetchParkingData() {
        apiService.fetchParkingData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let parkingData):
                    
                    let parkingInfos = parkingData.map { apiParkingInfo -> ParkingModel.ParkingInfo in
                        return ParkingModel.ParkingInfo(
                            name: apiParkingInfo.name,
                            description: apiParkingInfo.description,
                            availableSpaces: apiParkingInfo.availablecapacity,
                            totalCapacity: apiParkingInfo.totalcapacity,
                            lastUpdate: apiParkingInfo.lastupdate,
                            isOpenNow: apiParkingInfo.isopennow == 1,
                            urlLinkAddress: apiParkingInfo.urllinkaddress,
                            location: ParkingModel.ParkingInfo.Location(
                                latitude: apiParkingInfo.location.lat,
                                longitude: apiParkingInfo.location.lon
                            )
                        )
                    }
                    self.model = ParkingModel(parkingInfos)
                    
                case .failure(let error):
                    print("Error fetching parking data: \(error)")
                }
            }
        }
    }
            
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

