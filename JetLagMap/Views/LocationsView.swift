//
//  LocationsView.swift
//  JetLagMap
//
//  Created by Pavlo Prokhorov on 18.04.2025.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
//    @State private var position: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    
    //@StateObject private var vm = LocationsViewModel()
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 600
    
    var body: some View {
        ZStack {
            mapLayer
            VStack(spacing: 0) {
               header
                .padding()
                .frame(maxWidth: maxWidthForIpad)
                Spacer()
                    
                locationsPreviewStack
                
            }
        }
        .sheet(item: $vm.sheetLocation) {
            
        } content: { location in
            LocationInformation2View(location: location)
        }

    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button {
                vm.toggleLocationsList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    //.font(.title2)
                    .font(vm.mapLocation.name.count + vm.mapLocation.cityName.count < 19 ? .title2 : .title3)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(minHeight: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down.circle.dotted")
                            .font(.title)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }

            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(position: $vm.mapRegion) {
            ForEach(vm.locations) { location in
                Annotation(coordinate: location.coordinates) {
                   LocationMapAnnotationView()
                    
                        .scaleEffect(vm.mapLocation == location ? 1.2 : 0.9)
                        
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                        .shadow(radius: 5)
                } label: {
                    
                }
                
            }
        }
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}

