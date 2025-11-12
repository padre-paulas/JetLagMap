//
//  LocationsListView.swift
//  JetLagMap
//
//  Created by Pavlo Prokhorov on 22.04.2025.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)   
                }
                .padding(.vertical, 4)
                // Standard implementation below
                //.listRowBackground(Color.clear)
                
                .listRowBackground(vm.mapLocation == location ? Color.secondary.opacity(0.3) : Color.clear)
                
            }
            
        }
        .listStyle(.plain)
        
    }
}

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}
