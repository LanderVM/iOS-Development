//
//  ParkingAppView.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 18/12/2023.
//

import SwiftUI

struct ParkingAppView: View {
    @ObservedObject var viewModel: ParkingViewModel
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
                ForEach(viewModel.parkings, id: \.name) { parking in
                    ParkingCard(parking: parking)
                }
            }
            .padding()
        }
    }
}

struct ParkingCard: View {
    let parking: ParkingModel.ParkingInfo

    var body: some View {
        VStack {
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
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            parking.navigateToAbout()
        }
    }
}

struct OccupiedView: View {
    var parking: ParkingModel.ParkingInfo

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(parking.occupation)")
                    .foregroundColor(.green)
                Text("/")
                Text("\(parking.totalCapacity)")
            }

            ProgressView(value: Float(parking.occupation),
                         total: Float(parking.totalCapacity))
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .frame(height: 10)

        }.frame(width: 130)
    }
}

struct ParkingAppView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingAppView(viewModel: ParkingViewModel())
    }
}


