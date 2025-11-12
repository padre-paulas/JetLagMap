//
//  JetLagMapApp.swift
//  JetLagMap
//
//  Created by Pavlo Prokhorov on 18.04.2025.
//

import SwiftUI

@main
struct JetLagMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
