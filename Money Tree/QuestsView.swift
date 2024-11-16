//
//  QuestsView.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI
import Forever

struct questData: Identifiable, Encodable, Decodable {
    var id = UUID()
    var starNum: Int
    var limit: Double
    var timeFor: Int
    var catagory: String
    
    func quest() -> String {
        return "\(limit == 0 ? "Do not spend" : "Spend less than") \(limit != 0 ? "$\(Int(limit)).\(Int(String(limit).split(separator: ".")[1]) ?? 0)" : "") on \(catagory) \(timeFor == 1 ? "today" : "for \(timeFor) days")"
    }
}

struct QuestsView: View {
    @State var Quests: [questData] = [
        questData(starNum: 1, limit: 30, timeFor: 1, catagory: "Food"),
        questData(starNum: 5, limit: 30, timeFor: 7, catagory: "Food"),
        questData(starNum: 1, limit: 0, timeFor: 7, catagory: "Shopping"),
        questData(starNum: 1, limit: 60, timeFor: 30, catagory: "Clothes"),
        questData(starNum: 3, limit: 50, timeFor: 2, catagory: "Food")
    ]
    
    @State var questLimitAlert = false
    
    @Binding var activeQuests: [questData]
    @Forever("availableQuests") var availableQuests: [questData] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    // Active Quests Section
                    Section(header: Text("Active Quests").bold().font(.system(size: 20))) {
                        if activeQuests.count > 0 {
                            ForEach(activeQuests, id: \.id) { quest in
                                QuestCard(quest: quest)
                            }
                            .onDelete(perform: deleteItems)
                        } else {
                            Text("You don't have any active quests yet 😔")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // Available Quests Section
                    Section(header: Text("Available Quests").bold().font(.system(size: 20))) {
                        ForEach(availableQuests, id: \.id) { quest in
                            VStack(spacing: 10) {
                                QuestCard(quest: quest)
                                Button {
                                    withAnimation {
                                        if activeQuests.count < 4 {
                                            availableQuests.removeAll(where: { $0.id == quest.id })
                                            activeQuests.append(quest)
                                            updateAvailQ()
                                        } else {
                                            questLimitAlert = true
                                        }
                                    }
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.blue)
                                            .frame(height: 40)
                                        Text("Start")
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                            }
                        }
                        
                        .alert("Quest Limit", isPresented: $questLimitAlert) {
                            Button("Ok", role: .cancel) {}
                        } message: {
                            Text("Complete your active quests to start new quests!")
                        }
                    }
                }
            }
            .onAppear {
                updateAvailQ()
            }
            .navigationTitle("Quests")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        withAnimation {
            activeQuests.remove(atOffsets: offsets)
        }
    }
    
    
    func updateAvailQ() {
        while availableQuests.count < 5 {
            var generating = true
            var randomQuest: questData
            repeat {
                randomQuest = Quests.randomElement()!
                generating = availableQuests.contains { $0.id == randomQuest.id }
            } while generating
            availableQuests.append(randomQuest)
        }
    }
}

struct QuestCard: View {
    var quest: questData
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(quest.quest())
                        .font(.headline)
                        .frame(maxHeight: .infinity)
                        .foregroundColor(.primary)
                }
                Spacer()
                Text("\(quest.starNum)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .background() {
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 50, height: 50)
                    }
                    .padding()
                
            }
            .padding()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(radius: 5)
                .padding()
        )
    }
}

// Preview



#Preview {
    QuestsView(activeQuests: .constant([]))
}
