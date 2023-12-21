//
//  Parking_GentApp.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 18/12/2023.
//

import SwiftUI

@main
struct Parking_GentApp: App {
    @StateObject var parkingViewModel = ParkingViewModel()
    
    var body: some Scene {
        WindowGroup {
            ParkingAppView(viewModel: parkingViewModel)
        }
    }
}


