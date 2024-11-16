//
//  HomePage.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI
import Forever

struct HomePage: View {
    @Forever("start") var stars: Int = 0
    
    @Forever("activeQuests") var activeQuests:[questData] = []
    @Binding var TabViewSelection: Int
    
    // State variables for the selected customizations
    @State private var selectedPot: String = "Starting Pot"
    @State private var selectedSoil: String = "soil1"
    @State private var selectedPlant: String = "plant"
    
    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20) {
                        // Top Bar with Stars
                        HStack {
                            Spacer()
                            HStack(spacing: 8) {
                                Text("\(stars)")
                                    .font(.largeTitle)
                                    .bold()
                                Image(systemName: "star.fill")
                                    .symbolRenderingMode(.multicolor)
                                    .font(.largeTitle)
                                    .shadow(color: Color("Gold"), radius: 5, x: 0, y: 2)
                            }
                            .padding(.top, 20)
                            .padding(.horizontal)
                        }
                        .navigationTitle("Home")
                        .navigationBarTitleDisplayMode(.large)
                        
                        // My Tree Section
                        NavigationLink(
                            destination: CustomisationView(
                                stars: $stars,
                                selectedPot: $selectedPot,
                                selectedSoil: $selectedSoil,
                                selectedPlant: $selectedPlant
                            )
                        ) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 380, height: 400)
                                    .shadow(radius: 10)
                                
                                VStack(spacing: 10) {
                                    Text("My Tree")
                                        .font(.title2)
                                        .bold()
                                        .padding(.top, 20)
                                    
                                    ZStack {
                                        Image(selectedPot)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 400, height: 400)
                                        Image(selectedSoil)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 400, height: 400)
                                        Image(selectedPlant)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 400, height: 400)
                                    }
                                }.offset(y:80)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Active Quests Header
                        HStack {
                            Text("Active Quests")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // Active Quests List
                        if activeQuests.count > 0 {
                            VStack(spacing: 15) {
                                ForEach(activeQuests, id: \.id) { quest in
                                    QuestCard(quest: quest)
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            // Empty State
                            Text("You don't have any active quests yet 😔")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.top, 20)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomePage(TabViewSelection: .constant(0))
}
