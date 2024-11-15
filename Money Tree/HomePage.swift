
//  HomePage.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI

struct HomePage: View {
    @State var stars: Int = 0  // Set initial star count here
    
    @Binding var activeQuests: [Quest]
    
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
                    
                    NavigationLink(destination: QuestsView(activeQuests: $activeQuests)) {
                        Text("Add expense")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                            .offset(x: 100, y: 40)
                        Image(systemName: "chevron.right")
                            .imageScale(.large)
                            .fontWeight(.heavy)
                            .offset(x: 100, y: 45)
                    }
                    
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
                    
                    HStack {
                        NavigationLink(destination: QuestsView(activeQuests: $activeQuests)) {
                            Text("View in Quests")
                                .font(.headline)
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.right")
                                .imageScale(.large)
                                .fontWeight(.heavy)
                        }
                        .padding(-100)
                        .offset(x: 33, y: -40)
                    }
                }
                
                
                if activeQuests.count != 0{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green)
                            .frame(width: 300, height: 100)
                        VStack {
                            Text("Do not spend more than $30 on food today")
                                .frame(width: 270)
                                .foregroundColor(Color.white)
                                .bold()
                            
                            HStack {
                                Text("1")
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
                .offset(y: -180)
            }
        }
    }
}

#Preview {
    HomePage(activeQuests: .constant([]))
}
