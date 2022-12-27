//
//  MapView.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 27/12/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: .init(latitude: 34.011_286, longitude: -116.166_868))
    }
}
