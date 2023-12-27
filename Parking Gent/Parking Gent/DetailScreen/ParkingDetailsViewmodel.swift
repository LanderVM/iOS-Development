//
//  ParkingDetailsViewmodel.swift
//  Parking Gent
//
//  Created by Lander Van Molle on 27/12/2023.
//

import Foundation
import MapKit

class ParkingDetailsViewModel: ObservableObject {
    private let dateFormatter: DateFormatter
    
    init(){
        //Source: https://stackoverflow.com/questions/35700281/how-do-i-convert-a-date-time-string-into-a-different-date-string
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Brussels")
    }
    
    //Source: https://www.hackingwithswift.com/books/ios-swiftui/integrating-mapkit-with-swiftui
    func openMapForPlace(_ parking: ParkingInfo) {
        let coordinates = CLLocationCoordinate2D(latitude: parking.location.latitude, longitude: parking.location.longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary: nil))
        mapItem.name = parking.name
        mapItem.openInMaps()
    }
    
    func formattedLastUpdatedTime(_ lastUpdate: String) -> String {
            if let lastUpdatedDate = dateFormatter.date(from: lastUpdate) {
                dateFormatter.dateFormat = "HH:mm, dd MMMM"
                return dateFormatter.string(from: lastUpdatedDate)
            } else {
                return lastUpdate
            }
        }
    
}
