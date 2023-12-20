//
//  ContentView.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 18/12/2023.
//

import SwiftUI

struct ParkingInfo {
    var name: String
    var description: String
    var occupation: Int
    var totalCapacity: Int
}

struct ContentView: View {
    let parkings: [ParkingInfo] = [
        ParkingInfo(name: "Vrijdagmarkt", description: "Ondergrondse parkeergarage Vrijdagmarkt in Gent", occupation: 94, totalCapacity: 595),
        ParkingInfo(name: "Savaanstraat", description: "Ondergrondse parkeergarage Savaanstraat in Gent", occupation: 64, totalCapacity: 530),
        ParkingInfo(name: "Ledeberg", description: "Bovengrondse parkeergarage Ledeberg in Gent", occupation: 32, totalCapacity: 495),
        ParkingInfo(name: "B-Park Gent Sint-Pieters", description: "Ondergrondse parkeergarage NMBS Gent-Sint-Pieters in Gent", occupation: 47, totalCapacity: 500),
        ParkingInfo(name: "Sint-Michiels", description: "Ondergrondse parkeergarage Sint-Michiels in Gent", occupation: 75, totalCapacity: 446),
        ParkingInfo(name: "Reep", description: "? parkeergarage Reep in Gent", occupation: 83, totalCapacity: 449),
        ParkingInfo(name: "Ramen", description: "Ondergrondse parkeergarage Ramen in Gent", occupation: 80, totalCapacity: 250),
        ParkingInfo(name: "Tolhuis", description: "Ondergrondse parkeergarage Tolhuis in Gent", occupation: 61, totalCapacity: 150),
        ParkingInfo(name: "Sint-Pietersplein", description: "? parkeergarage Sint-Pietersplein in Gent", occupation: 59, totalCapacity: 683),
        ParkingInfo(name: "Getouw", description: "Bovengrondse parkeergarage Het Getouw in Gent", occupation: 2, totalCapacity: 350)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                ForEach(parkings, id: \.name) { parking in
                    ParkingCard(parking: parking) { selectedParking in
                        print("Selected parking: \(selectedParking)")
                    }
                }
            }
            .padding()
        }
    }
}

struct ParkingCard: View {
    var parking: ParkingInfo
    var navigateToAbout: (String) -> Void

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(parking.name)
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                        .lineLimit(1)
                        .padding(.bottom, 1)
                    Text(parking.description)
                        .font(.caption)
                }
                Spacer()
                OccupiedView(parking: parking)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            navigateToAbout(parking.name)
        }
    }
}

struct OccupiedView: View {
    var parking: ParkingInfo

    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("\(parking.occupation)")
                    .foregroundColor(.green)
                Text("/")
                Text("\(parking.totalCapacity)")
            }
            
            ProgressView(value: Float(parking.occupation)
                         , total: Float(parking.totalCapacity))
            .progressViewStyle(LinearProgressViewStyle(tint: .green))
            .frame(height: 10)
            
        }.frame(width: 130)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
