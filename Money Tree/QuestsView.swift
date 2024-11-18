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
    let timeFor: Int
    var catagory: String
    var timeLeft: Int?
    var status: Bool?
    
    func quest() -> String {
        return "\(limit == 0 ? "Do not spend" : "Spend less than") \(limit != 0 ? "$\(Int(limit)).\(Int(String(limit).split(separator: ".")[1]) ?? 0)" : "") on \(catagory) \(timeFor == 1 ? "today" : "for \((timeLeft ?? nil == nil) ? timeFor : timeLeft!) days")"
    }
    func Status() -> Int{
        return ( ((status) ?? nil == nil) ? 1 : (status! ? 2 : 3) )
    }
    mutating func Start(){
        timeLeft = timeFor
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
    @State var animatedAvailableQuests: [questData] = []
    @State var animatedActiveQuests: [questData] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    // Active Quests Section
                    Section(header: Text("Active Quests").bold().font(.system(size: 20))) {
                        if animatedActiveQuests.count > 0 {
                            ForEach(animatedActiveQuests, id: \.id) { quest in
                                QuestCard(quest: quest, activeQuests: $animatedActiveQuests, stars: $stars)
                            }
                            .onDelete(perform: deleteItems)
                        } else {
                            Text("You don't have any active quests yet 😔")
                                .foregroundColor(Color.secondary)
                        }
                    }
                    
                    // Available Quests Section
                    Section(header: Text("Available Quests").bold().font(.system(size: 20))) {
                        ForEach(0..<animatedAvailableQuests.count, id: \.self) { questIndx in
                            VStack(spacing: 10) {
                                QuestCard(quest: animatedAvailableQuests[questIndx], activeQuests: $animatedActiveQuests, stars: $stars)
                                Button {
                                    withAnimation {
                                        if animatedActiveQuests.count < 4 {
                                            animatedAvailableQuests[questIndx].Start()
                                            animatedActiveQuests.append(animatedAvailableQuests[questIndx])
                                            animatedAvailableQuests.remove(at: questIndx)
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

//                        ForEach(animatedAvailableQuests, id: \.id) { quest in
//                            VStack(spacing: 10) {
//                                QuestCard(quest: quest, activeQuests: $animatedActiveQuests, stars: $stars)
//                                Button {
//                                    withAnimation {
//                                        if animatedActiveQuests.count < 4 {
//                                            animatedAvailableQuests[animatedAvailableQuests.firstIndex(where: { $0.id == quest.id })].Start()
//                                            animatedAvailableQuests.removeAll(where: { $0.id == quest.id })
//                                            animatedActiveQuests.append(quest)
//                                            updateAvailQ()
//                                        } else {
//                                            questLimitAlert = true
//                                        }
//                                    }
//                                } label: {
//                                    ZStack {
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .fill(Color.blue)
//                                            .frame(height: 40)
//                                        Text("Start")
//                                            .foregroundColor(.white)
//                                            .bold()
//                                    }
//                                }
//                            }
//                        }
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
        .onAppear {
            animatedActiveQuests = activeQuests
            animatedAvailableQuests = availableQuests
        }
        .onChange(of: animatedActiveQuests) {
            activeQuests = animatedActiveQuests
        }
        .onChange(of: animatedAvailableQuests) {
            availableQuests = animatedAvailableQuests
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        withAnimation {
            animatedActiveQuests.remove(atOffsets: offsets)
            activeQuests = animatedActiveQuests
        }
    }

    func updateAvailQ() {
        while animatedAvailableQuests.count < 5 {
            var generating = true
            var randomQuest: questData
            repeat {
                randomQuest = Quests.randomElement()!
                generating = animatedAvailableQuests.contains { $0.id == randomQuest.id }
            } while generating
            animatedAvailableQuests.append(randomQuest)
        }
    }
}

struct QuestCard: View {
    var quest: questData
    @Binding var activeQuests: [questData]
    @Binding var stars: Int
    @State var animatedActiveQuests: [questData] = []
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(quest.quest())
                        .font(.headline)
                        .frame(maxHeight: .infinity)
                        .foregroundColor(Color.primary) // Adaptive color
                }
                Spacer()
                Text("\(quest.starNum)")
                    .font(.headline)
                    .foregroundColor(Color.yellow)
                    .padding()
                    .background() {
                        Image(systemName: "star.fill")
                            .imageScale(.large)
                            .foregroundStyle(.yellow)
                            .shadow(radius: 5)
                    }
            }
            .padding()
            
            if quest.Status() == 2 {
                Button {
                    withAnimation {
                        stars += quest.starNum
                        animatedActiveQuests.removeAll(where: { $0.id == quest.id })
                    }
                } label: {
                    Text("Complete")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            } else if quest.Status() == 3 {
                Button {
                    withAnimation {
                        animatedActiveQuests.removeAll(where: { $0.id == quest.id })
                    }
                } label: {
                    Text("Failed")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }else if (quest.timeLeft ?? nil) != nil{
//                ProgressView(label: "Time Left:", value: quest.timeLeft!, total: quest.timeFor)
                ProgressView("Time Left: ", value: Double(quest.timeFor - quest.timeLeft!) / Double(quest.timeFor))
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(quest.Status() == 1 ? Color(UIColor.systemBackground) :
                      (quest.Status() == 2 ? Color.green.opacity(0.2) : Color.red.opacity(0.2)))
                .shadow(radius: 5)
        )
        .onAppear {
            animatedActiveQuests = activeQuests
        }
        .onChange(of: animatedActiveQuests) {
            activeQuests = animatedActiveQuests
        }
    }
}

