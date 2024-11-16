
//  HomePage.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI

struct HomePage: View {
    @State var stars: Int = 0  // Set initial star count here
    
    @Binding var activeQuests: [questData]
    @Binding var TabViewSelection: Int
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    HStack {
                        Text("\(stars)")
                            .font(.largeTitle)
                            .offset(x: 150, y: 20)
                            .bold()
                        Image(systemName: "star.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.largeTitle)
                            .offset(x: 150, y: 20)
                            .shadow(color: Color("Gold"), radius: 50, y: 5)
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.large)
                    
                    
                    ZStack {
                        
                        NavigationLink(destination: CustomisationView(stars: $stars)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 380, height: 430)
                                    .foregroundColor(Color.gray.opacity(0.4))
                                Text("My Tree")
                                    .font(.title2)
                                    .offset(y: -170)
                                    .bold()
                                ZStack {
                                    Image("Starting Pot")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 600, height: 600)
                                    Image("plant")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 600, height: 600)
                                    Image("soil1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 600, height: 600)
                                }
                                .offset(y: 130)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .offset(y: -35)
                    }
                }
                
                HStack{
                    Text("Active Quests")
                        .font(.largeTitle)
                        .bold()
                        .offset(x: -70, y: -130)
                }
                
                
                if activeQuests.count != 0{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green)
                            .frame(width: 300, height: 100)
                        VStack {
                            Text(activeQuests[0].quest())
                                .frame(width: 270)
                                .foregroundColor(Color.white)
                                .bold()
                                .padding()
                            
                            HStack {
                                Text(String(activeQuests[0].starNum))
                                    .font(.system(size: 20))
                                    .padding(.top, 10)
                                    .foregroundColor(Color.white)
                                    .bold()
                                Image(systemName: "star.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .padding(.top, 7)
                            }
                        }
                    }
                    .offset(y: -130)
                }else{
                    Text("You don't have any active quests yet :(")
                        .offset(y: -120)
                }
            }
        }
    }
}

#Preview {
    HomePage(activeQuests: .constant([]), TabViewSelection: .constant(0))
}
