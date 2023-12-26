//
//  ParkingAPIResponseModel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 26/12/2023.
//

import Foundation

struct ParkingAPIResponse: Codable {
    let results: [ParkingInfo]
    
    struct ParkingInfo: Codable {
        let name: String
        let lastupdate: String
        let totalcapacity: Int
        let availablecapacity: Int
        let occupation: Int
        let type: String
        let description: String
        let id: String
        let openingtimesdescription: String
        let isopennow: Int
        let temporaryclosed: Int
        let operatorinformation: String
        let freeparking: Int
        let urllinkaddress: String
        let occupancytrend: String
        let locationanddimension: String
        let location: Location
    }

    struct Location: Codable {
        let lon: Double
        let lat: Double
    }
}
