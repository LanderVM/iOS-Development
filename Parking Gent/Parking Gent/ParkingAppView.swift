//
//  ParkingAppView.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 18/12/2023.
//

import SwiftUI

struct ParkingAppView: View {
    @ObservedObject var viewModel: ParkingViewModel
    @State private var selectedFilter: FilterOption = .name

    var body: some View {
        VStack {
            Text("Parking Gent")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            Picker("Filter", selection: $selectedFilter) {
                Text("By Name").tag(FilterOption.name)
                Text("By Free Spaces").tag(FilterOption.freeSpaces)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.bottom, 10)
            .onChange(of: selectedFilter) { newFilter in
                viewModel.setFilterOption(newFilter)
            }
            
            ScrollView {
                LazyVStack{
                    ForEach(viewModel.filteredParkings(), id: \.name) { parking in
                        ParkingCard(parking: parking)
                    }
                }
                .padding()
            }
        }
    }
}

struct ParkingCard: View {
    let parking: ParkingModel.ParkingInfo

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
    var parking: ParkingModel.ParkingInfo

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("\(parking.availableSpaces)")
                    .foregroundColor(.green)
                Text("/")
                Text("\(parking.totalCapacity)")
            }

            ProgressView(value: Float(parking.availableSpaces),
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


