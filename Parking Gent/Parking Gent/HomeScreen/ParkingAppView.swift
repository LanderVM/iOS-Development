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
        NavigationView{
            VStack{
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
                            NavigationLink(destination: ParkingDetailView(parking: parking)){
                                ParkingCardView(parking: parking)
                            }
                        }
                    }
                    .padding()
                }.refreshable {
                    viewModel.refreshParkingData()
                }
            }.navigationBarTitle("Parking Gent")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ParkingAppView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingAppView(viewModel: ParkingViewModel())
    }
}


