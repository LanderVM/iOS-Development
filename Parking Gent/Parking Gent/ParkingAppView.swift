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
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    }
                    ForEach(viewModel.filteredParkings(), id: \.name) { parking in
                        ParkingCardView(parking: parking)
                    }
                }
                .padding()
            }
        }
    }
}

struct ParkingAppView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingAppView(viewModel: ParkingViewModel())
    }
}


