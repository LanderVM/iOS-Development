//
//  ParkingViewmodel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 21/12/2023.
//

import SwiftUI

class ParkingViewModel: ObservableObject {
    @Published private var model: ParkingModel
    @Published var isLoading: Bool = false
    private let apiService: ParkingAPIService
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("Autosaved.parkingGent")

    init(apiService: ParkingAPIService = ParkingAPIService()) {
        self.apiService = apiService
        self.model = ParkingModel([])
        fetchParkingData()
    }
    
    private func saveModel(){
        do {
            let data = try model.json()
            try data.write(to: autosaveURL)
        } catch let error {
            print("Error while saving: \(error.localizedDescription)")
        }
    }

    func fetchParkingData() {
        isLoading = true
        apiService.fetchParkingData { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let parkingData):
                    let parkingInfos = parkingData.map { apiParkingInfo -> ParkingModel.ParkingInfo in
                        return ParkingModel.ParkingInfo(
                            name: apiParkingInfo.name,
                            lastUpdate: apiParkingInfo.lastupdate,
                            totalCapacity: apiParkingInfo.totalcapacity,
                            availableCapacity: apiParkingInfo.availablecapacity,
                            occupation: apiParkingInfo.occupation,
                            type: apiParkingInfo.type,
                            description: apiParkingInfo.description,
                            id: apiParkingInfo.id,
                            openingtimesDescription: apiParkingInfo.openingtimesdescription,
                            isOpenNow: apiParkingInfo.isopennow == 1,
                            operatorInformation: apiParkingInfo.operatorinformation,
                            isFreeParking: apiParkingInfo.freeparking == 1,
                            urlLinkAddress: apiParkingInfo.urllinkaddress,
                            location: ParkingModel.ParkingInfo.Location(
                                latitude: apiParkingInfo.location.lat,
                                longitude: apiParkingInfo.location.lon
                            )
                        )
                    }
                    self?.model = ParkingModel(parkingInfos)
                    self?.saveModel()
                case .failure(let error):
                    print("Error fetching parking data: \(error)")
                    if let data = try? Data(contentsOf: self?.autosaveURL ?? URL(fileURLWithPath: "")),
                    let autosavedData = try? ParkingModel(json: data) {
                        self?.model = autosavedData
                    }
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
            return model.parkings.sorted(by: { $0.name < $1.name })
        case .freeSpaces:
            return model.parkings.sorted(by: { $0.availableCapacity > $1.availableCapacity })
        }
    }
    
    func setFilterOption(_ option: FilterOption) {
        model.filterOption = option
    }
}

enum FilterOption: Codable {
    case name
    case freeSpaces
}

