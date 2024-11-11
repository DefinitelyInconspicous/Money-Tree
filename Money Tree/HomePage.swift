//
//  HomePage.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI

struct HomePage: View {
    var stars: Int = 0
    var body: some View {
        VStack{
            NavigationStack {
                VStack{
                    HStack {
                        Text("\(stars)")
                            .font(.largeTitle)
                            .offset(x: 150, y:-370)
                            .bold()
                        Image(systemName: "star.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.largeTitle)
                            .offset(x: 150, y:-370)
                            .shadow(color: Color("Gold"), radius: 50, y: 5)
                        
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.large)
                    
                 
                }
            }
        }
    }
}

#Preview {
    HomePage()
}
