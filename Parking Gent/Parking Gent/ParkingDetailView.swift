//
//  ParkingDetailView.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 26/12/2023.
//

import SwiftUI

struct ParkingDetailView: View {
    var parking: ParkingModel.ParkingInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "car.fill")
                    .foregroundColor(.blue)
                Text(parking.name)
                    .font(.title)
                    .fontWeight(.bold)
            }

            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
                Text(parking.description)
                    .font(.body)
            }

            HStack {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.orange)
                Text("Last updated: \(parking.lastUpdate)")
                    .font(.body)
            }

            HStack {
                Image(systemName: parking.isOpenNow ? "lock.open.fill" : "lock.fill")
                    .foregroundColor(parking.isOpenNow ? .green : .red)
                Text(parking.isOpenNow ? "Open Now" : "Closed")
                    .font(.body)
            }

            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.purple)
                Text("Capacity: \(parking.availableCapacity)/\(parking.totalCapacity)")
                    .font(.body)
            }

            Spacer()

            if let url = URL(string: parking.id), UIApplication.shared.canOpenURL(url) {
                Button(action: {
                    UIApplication.shared.open(url)
                }) {
                    HStack {
                        Image(systemName: "link.circle.fill")
                            .foregroundColor(.blue)
                        Text("More Information")
                            .foregroundColor(.blue)
                            .font(.body)
                    }
                }
            }
        }
        .padding()
        .navigationBarTitle(Text(parking.name), displayMode: .inline)
    }
}

struct ParkingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingDetailView(parking: ParkingInfo(
            name: "Savaanstraat",
            lastUpdate: "2023-12-26T23:26:02+01:00",
            totalCapacity: 200,
            availableCapacity: 150,
            occupation: 25,
            type: "carPark",
            description: "Ondergrondse parkeergarage Savaanstraat in Gent",
            id: "https://stad.gent/nl/mobiliteit-openbare-werken/parkeren/parkings-gent/parking-savaanstraat",
            openingtimesDescription: "24/7",
            isOpenNow: true,
            temporaryClosed: false,
            operatorInformation: "Mobiliteitsbedrijf Gent",
            isFreeParking: false,
            urlLinkAddress: "https://stad.gent/nl/mobiliteit-openbare-werken/parkeren/parkings-gent/parking-savaanstraat",
            locationAndDimension: """
                {
                    "specificAccessInformation": ["inrit"],
                    "level": "0",
                    "roadNumber": "?",
                    "roadName": "Savaanstraat 13\n9000 Gent",
                    "contactDetailsTelephoneNumber": "Tel.: 09 266 29 40",
                    "coordinatesForDisplay": {
                        "latitude": 51.04877362543108,
                        "longitude": 3.7234627726667133
                    }
                }
            """,
            location: ParkingInfo.Location(latitude: 51.04877362543108, longitude: 3.7234627726667133)
        ))
    }
}
