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
    
    var body: some View {
        ScrollView {
            ParkingCard(parking: ParkingInfo(name: "Tolhuis", description: "Ondergrondse parkeergarage Tolhuis in Gent", occupation: 100, totalCapacity: 150)) { selectedParking in
                print("Selected parking: \(selectedParking)")
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
                    Text(parking.description)
                        .font(.caption)
                }

                Spacer()

                VStack(spacing: 0) {
                    OccupiedView(parking: parking)
                }
                .frame(width: 150)
                
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
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
