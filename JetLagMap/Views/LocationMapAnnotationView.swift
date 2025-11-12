//
//  LocationMapAnnotationView.swift
//  JetLagMap
//
//  Created by Pavlo Prokhorov on 23.04.2025.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    var body: some View {
        
        VStack {
            
                
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(width: 25, height: 25)
                    .rotationEffect(Angle(degrees: 45))
                    .offset(y: 63)
                
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 50, height: 50)
                    .overlay {
                        //                        Circle()
                        //                            .fill(Color(#colorLiteral(red: 0.9492090344, green: 0.6246145368, blue: 0.02956103534, alpha: 1)))
                        //                            .frame(width: 42, height: 42)
                        Image("JetLagLogo")
                            .resizable()
                            .frame(width: 42, height: 42)
                            .clipShape(Circle())
                        
                    }
                
            }
            
            .offset(y: -50)
//            .padding(.bottom, 50)
        
       
    }
}

#Preview {
    LocationMapAnnotationView()
        
}
