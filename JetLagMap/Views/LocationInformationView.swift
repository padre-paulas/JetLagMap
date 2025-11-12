//
//  LocationInformationView.swift
//  JetLagMap
//
//  Created by Pavlo Prokhorov on 25.04.2025.
//

import SwiftUI

struct LocationInformationView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.clear
            VStack(spacing: 20) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .padding()
                    .tint(.red)
                    .font(.title)
                    Spacer()
                }
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.accent)
                    .padding(.top, 40)
                
                Spacer()
                
                HStack(spacing: 20) {
                    
                    Image(vm.mapLocation.imageNames[0] /*?? systemName: "questionmark.square.dashed"*/)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Image(vm.mapLocation.imageNames[1])
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Image(vm.mapLocation.imageNames[2])
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(30)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        
                        .stroke(Color.accentColor, lineWidth: 4)
                        .padding(10)
                )
                
                .clipShape(RoundedRectangle(cornerRadius: 20))
                //.border(.accent, width: 3)
                
                
                Text(vm.mapLocation.description)
                    .padding(.horizontal)
                Spacer()
               
                    //Link("Go to wikipedia to learn more...", destination: URL(string: vm.mapLocation.link)!)
                Link(destination: URL(string: vm.mapLocation.link) ?? URL(string: "https://google.com")!, label: {
                    Text("Go to wikipedia to learn more...")
                        .underline()
                })
                    .font(.caption)
                    .foregroundStyle(.blue)
                    
                
                
                
                Spacer()
                Spacer()
            }
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    LocationInformationView()
        .environmentObject(LocationsViewModel())
}
