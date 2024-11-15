//
//  CustomisationView.swift
//  Money Tree
//
//  Created by T Krobot on 15/11/24.
//
import SwiftUI

struct CustomisationView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Customisation Page")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer() // Adds flexible space for future content
            }
            .navigationTitle("Customise Your Tree")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CustomisationView()
}

