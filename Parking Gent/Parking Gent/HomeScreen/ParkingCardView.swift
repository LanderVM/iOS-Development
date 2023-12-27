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
    @Environment(\.colorScheme) var colorScheme

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
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? Color.black : Color.white)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 3)
        )
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
                Text("\(parking.availableCapacity)")
                    .foregroundColor(occupancyColor(a: parking.availableCapacity, tot: parking.totalCapacity))
                Text("/")
                Text("\(parking.totalCapacity)")
                    .foregroundColor(Color.blue)
            }

            ProgressView(value: Float(parking.availableCapacity),
                         total: Float(parking.totalCapacity))
            .progressViewStyle(LinearProgressViewStyle(tint: occupancyColor(a: parking.availableCapacity, tot: parking.totalCapacity)))
                .frame(height: 10)

        }.frame(width: 130)
    }
}

struct ParkingCardView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleParkings = [
            ParkingInfo(
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
                operatorInformation: "Mobiliteitsbedrijf Gent",
                isFreeParking: false,
                urlLinkAddress: "https://stad.gent/nl/mobiliteit-openbare-werken/parkeren/parkings-gent/parking-savaanstraat",
                location: ParkingInfo.Location(latitude: 51.04877362543108, longitude: 3.7234627726667133)
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

