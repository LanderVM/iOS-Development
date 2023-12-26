//
//  ParkingCardView.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 23/12/2023.
//

import SwiftUI
typealias ParkingInfo = ParkingModel.ParkingInfo

struct ParkingCardView: View {
    let parking: ParkingInfo

    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(parking.name)
                        .font(.headline)
                        .lineLimit(1)
                        .padding(.bottom, 1)
                    Text(parking.description)
                        .font(.caption)
                }
                Spacer()
                OccupiedView(parking: parking)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .onTapGesture {
            parking.navigateToAbout()
        }
    }
}

struct OccupiedView: View {
    var parking: ParkingInfo
    
    private func occupancyColor(a: Int, tot: Int) -> Color {
        let ratio = Double(a) / Double(tot)
        
        switch ratio {
        case ..<0.2:
            return Color.red
        case 0.2..<0.5:
            return Color.orange
        default:
            return Color.green
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(parking.availableSpaces)")
                    .foregroundColor(occupancyColor(a: parking.availableSpaces, tot: parking.totalCapacity))
                Text("/")
                Text("\(parking.totalCapacity)")
            }

            ProgressView(value: Float(parking.availableSpaces),
                         total: Float(parking.totalCapacity))
            .progressViewStyle(LinearProgressViewStyle(tint: occupancyColor(a: parking.availableSpaces, tot: parking.totalCapacity)))
                .frame(height: 10)

        }.frame(width: 130)
    }
}

struct ParkingCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleParkings = [
            ParkingInfo(
                name: "Savaanstraat",
                description: "Ondergrondse parkeergarage Savaanstraat in Gent",
                availableSpaces: 150,
                totalCapacity: 200,
                lastUpdate: "2023-12-26T23:26:02+01:00",
                isOpenNow: true,
                urlLinkAddress: "https://stad.gent/nl/mobiliteit-openbare-werken/parkeren/parkings-gent/parking-savaanstraat",
                location: ParkingInfo.Location(latitude: 51.04877362543108, longitude: 3.7234627726667133)
            ),
            ParkingInfo(
                name: "Vrijdagmarkt",
                description: "Ondergrondse parkeergarage Vrijdagmarkt in Gent",
                availableSpaces: 23,
                totalCapacity: 595,
                lastUpdate: "2023-12-26T23:30:36+01:00",
                isOpenNow: true,
                urlLinkAddress: "https://stad.gent/nl/mobiliteit-openbare-werken/parkeren/parkings-gent/parking-vrijdagmarkt",
                location: ParkingInfo.Location(latitude: 51.05713405953412, longitude: 3.726071777876147)
            ),
            ParkingInfo(
                name: "Sint-Michiels",
                description: "Ondergrondse parkeergarage Sint-Michiels in Gent",
                availableSpaces: 202,
                totalCapacity: 451,
                lastUpdate: "2023-12-26T23:29:42+01:00",
                isOpenNow: true,
                urlLinkAddress: "https://stad.gent/nl/mobiliteit-openbare-werken/parkeren/parkings-gent/parking-sint-michiels",
                location: ParkingInfo.Location(latitude: 51.05311004768356, longitude: 3.719727740000235)
            )
        ]
        return VStack{
            ForEach(sampleParkings, id: \.name) { parking in
                ParkingCardView(parking: parking)
                .padding()
            }
        }
    }
}
