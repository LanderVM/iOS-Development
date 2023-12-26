//
//  ParkingAPIService.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 26/12/2023.
//

import Foundation

class ParkingAPIService {
    let baseUrl = "https://data.stad.gent/api/explore/v2.1/catalog/datasets/bezetting-parkeergarages-real-time/records"
    
    func fetchParkingData(completion: @escaping (Result<[ParkingAPIResponse.ParkingInfo], Error>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(ParkingAPIResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
