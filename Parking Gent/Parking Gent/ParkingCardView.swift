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
        case 0.50...1.0:
            return Color.green
        case 0.2..<0.5:
            return Color.orange
        default:
            return Color.red
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
        VStack{
            ParkingCardView(parking: ParkingInfo(name: "Vrijdagmarkt", description: "Ondergrondse parkeergarage Vrijdagmarkt in Gent", availableSpaces: 354, totalCapacity: 595))
            ParkingCardView(parking: ParkingInfo(name: "Ramen", description: "Ondergrondse parkeergarage Ramen in Gent", availableSpaces: 80, totalCapacity: 250))
            ParkingCardView(parking: ParkingInfo(name: "B-Park Gent Sint-Pieters", description: "Ondergrondse parkeergarage NMBS Gent-Sint-Pieters in Gent", availableSpaces: 47, totalCapacity: 500))
        }
    }
}
