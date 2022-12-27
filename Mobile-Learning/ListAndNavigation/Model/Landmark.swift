//
//  Landmark.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 27/12/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    let id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    
    private var imageName: String
    
    var image: Image {
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    
    var locationCoordinate: CLLocationCoordinate2D {
        .init(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        let latitude: Double
        let longitude: Double
    }
}
