//
//  ParkingViewmodel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 21/12/2023.
//

import SwiftUI

class ParkingViewModel: ObservableObject {
    @Published private var model: ParkingModel{
        didSet{
            autosave()
        }
    }
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("Autosaved.parkingGent")
    
    private func autosave(){
        save(to: autosaveURL)
        print("autosaved to \(autosaveURL)")
    }
    
    private func save(to url: URL){
        do {
            let data = try model.json()
            try data.write(to: url)
        } catch let error {
            print("Error while saving: \(error.localizedDescription)")
        }
    }
    
    @Published var isLoading: Bool = false
    private let apiService: ParkingAPIService

    init(apiService: ParkingAPIService = ParkingAPIService()) {
        self.apiService = apiService
        self.model = ParkingModel([])
        fetchParkingData()
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
                    self?.model = ParkingModel(parkingInfos)
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

enum FilterOption: Codable {
    case name
    case freeSpaces
}

