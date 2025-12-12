//
//  LocationInformation2View.swift
//  JetLagMap
//
//  Created by Pavlo Prokhorov on 25.04.2025.
//

import SwiftUI
import MapKit

struct LocationInformation2View: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
               imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

extension LocationInformation2View {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    //.frame(maxWidth: .infinity)
            }
        }
        .frame(height: 400)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(Color.accentColor)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
            
            if let url = URL(string: location.link) {
                Link(destination: url) {
                    Text("Read more on Wikipedia")
                        .italic()
                        .font(.headline)
                        .underline()
                        .foregroundStyle(Color.blue)
                }
            }
            
        }
    }
    
    private var mapLayer: some View {
//        Map(position: .constant(MapCameraPosition.region(MKCoordinateRegion(center: location.coordinates, span: vm.mapSpan)))) {
//            ForEach($vm.locations) { location in
//                Annotation(coordinate: location.coordinates) {
//                    
//                }
//                
//            }
//
//        }
       // Text("")
//        let mapPosition: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
//        Map(position: $vm.mapRegion) {
//            ForEach(vm.locations) { location in
//                Annotation(coordinate: location.coordinates)
//            }
//        }
        
//        Map(position: $vm.mapRegion) {
//            ForEach(vm.locations) { location in
//                Annotation(coordinate: location.coordinates) {
//                   LocationMapAnnotationView()
//                        .scaleEffect(vm.mapLocation == location ? 1.2 : 0.9)
//                        .shadow(radius: 5)
//                        .onTapGesture {
//                            vm.showNextLocation(location: location)
//                        }
//                } label: {
//                    
//                }
//            }
//        }
        
        Map(position: .constant(.region(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))) {
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .shadow(radius: 10)
                }
            }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    private var backButton: some View {
        Button {
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.primary)
                .background(.regularMaterial)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
                .clipShape(Circle())
                .shadow(radius: 4)
                .padding()
        }

    }
}

#Preview {
    LocationInformation2View(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}
