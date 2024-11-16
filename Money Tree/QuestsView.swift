//
//  QuestsView.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI
import Forever

struct questData: Identifiable, Encodable, Decodable, Equatable {
    var id = UUID()
    var starNum: Int
    var limit: Double
    var timeFor: Int
    var catagory: String
    var status: Bool?
    
    func quest() -> String {
        return "\(limit == 0 ? "Do not spend" : "Spend less than") \(limit != 0 ? "$\(Int(limit)).\(Int(String(limit).split(separator: ".")[1]) ?? 0)" : "") on \(catagory) \(timeFor == 1 ? "today" : "for \(timeFor) days")"
    }
    func Status() -> Int{
        return ( ((status) ?? nil == nil) ? 1 : (status! ? 2 : 3) )
    }
}


struct QuestsView: View {
    @State var Quests: [questData] = [ // ALL QUESTS
        questData(starNum: 1, limit: 30, timeFor: 1, catagory: "Food"),
        questData(starNum: 5, limit: 30, timeFor: 7, catagory: "Food"),
        questData(starNum: 1, limit: 0, timeFor: 7, catagory: "Shopping"),
        questData(starNum: 1, limit: 60, timeFor: 30, catagory: "Clothes"),
        questData(starNum: 3, limit: 50, timeFor: 2, catagory: "Food"),
        questData(starNum: 4, limit: 100, timeFor: 30, catagory: "Entertainment"),
        questData(starNum: 2, limit: 30, timeFor: 5, catagory: "Transportation"),
        questData(starNum: 3, limit: 50, timeFor: 7, catagory: "Shopping"),
        questData(starNum: 2, limit: 20, timeFor: 7, catagory: "Food"),
        questData(starNum: 2, limit: 0, timeFor: 1, catagory: "Essentials"),
        questData(starNum: 3, limit: 15, timeFor: 2, catagory: "Entertainment"),
        questData(starNum: 2, limit: 0, timeFor: 7, catagory: "Entertainment"),
        questData(starNum: 3, limit: 0, timeFor: 3, catagory: "Essentials"),
        questData(starNum: 4, limit: 0, timeFor: 10, catagory: "Entertainment"),
        questData(starNum: 1, limit: 20, timeFor: 1, catagory: "Shopping"),
        questData(starNum: 4, limit: 100, timeFor: 30, catagory: "Food"),
        questData(starNum: 2, limit: 30, timeFor: 2, catagory: "Entertainment"),
        questData(starNum: 3, limit: 0, timeFor: 7, catagory: "Entertainment"),
        questData(starNum: 2, limit: 25, timeFor: 7, catagory: "Food"),
        questData(starNum: 3, limit: 0, timeFor: 10, catagory: "Clothes"),
        questData(starNum: 5, limit: 40, timeFor: 30, catagory: "Entertainment"),
        questData(starNum: 1, limit: 10, timeFor: 1, catagory: "Food"),
        questData(starNum: 3, limit: 0, timeFor: 2, catagory: "Essentials"),
        questData(starNum: 4, limit: 50, timeFor: 30, catagory: "Transportation"),
        questData(starNum: 2, limit: 5, timeFor: 7, catagory: "Entertainment"),
        questData(starNum: 2, limit: 0, timeFor: 2, catagory: "Shopping"),
        questData(starNum: 5, limit: 0, timeFor: 30, catagory: "Entertainment"),
        questData(starNum: 5, limit: 0, timeFor: 14, catagory: "Shopping"),
        questData(starNum: 3, limit: 150, timeFor: 30, catagory: "Food"),
        questData(starNum: 3, limit: 40, timeFor: 2, catagory: "Food"),
        questData(starNum: 3, limit: 0, timeFor: 7, catagory: "Essentials"),
        questData(starNum: 1, limit: 0, timeFor: 1, catagory: "Entertainment"),
        questData(starNum: 3, limit: 15, timeFor: 7, catagory: "Transportation"),
        questData(starNum: 2, limit: 0, timeFor: 2, catagory: "Shopping"),
        questData(starNum: 4, limit: 0, timeFor: 7, catagory: "Entertainment"),
        questData(starNum: 3, limit: 50, timeFor: 30, catagory: "Essentials"),
        questData(starNum: 2, limit: 20, timeFor: 7, catagory: "Essentials")
    ]
    
    
    @State var questLimitAlert = false
    
    @Binding var availableQuests: [questData]
    @Binding var activeQuests: [questData]
    @Binding var stars: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    // Active Quests Section
                    Section(header: Text("Active Quests").bold().font(.system(size: 20))) {
                        if activeQuests.count > 0 {
                            ForEach(activeQuests, id: \.id) { quest in
                                QuestCard(quest: quest, activeQuests: $activeQuests, stars: $stars)
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
                                QuestCard(quest: quest, activeQuests: $activeQuests, stars: $stars)
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
                    }
                    .alert("QUEST LIMIT", isPresented: $questLimitAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("Complete your active quests to start new quests!")
                    }
                }
            }
            .navigationTitle("Quests")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                updateAvailQ()
            }
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
    @Binding var activeQuests: [questData]
    @Binding var stars: Int
    
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
            
            if quest.Status() == 2{
                Button{
                    withAnimation{
                        stars += quest.starNum
                        activeQuests.removeAll(where: { $0.id == quest.id })
                        print(activeQuests)
                        print(quest.id)
                    }
                } label: {
                    Text("Complete")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundStyle(Color.white)
                }
                .padding(.top, -30)
            }else if quest.Status() == 3{
                Button{
                    withAnimation{
                        activeQuests.removeAll(where: { $0.id == quest.id })
                    }
                } label: {
                    Text("Failed")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundStyle(Color.white)
                }
                .padding(.top, -30)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(quest.Status() == 1 ? Color.white : quest.Status() == 2 ? Color.green : Color.red)
                .shadow(radius: 5)
                .padding()
        )
    }
}
