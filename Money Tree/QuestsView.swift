//
//  QuestsView.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI

struct questData{
    let id = UUID()
    var quest: String
    var starNum: Int
}

struct QuestsView: View {
    @State var Quests: [questData] = [
        questData(quest: "Do not spend more than $30 on food today.", starNum: 1),
        questData(quest: "Do not spend more than $30 on food this week.", starNum: 5),
        questData(quest: "Don’t online shop this week", starNum: 1),
        questData(quest: "Spend less than $60 on clothes this month.", starNum: 1),
        questData(quest: "Limit takeout expenses to $20 this weekend.", starNum: 2),
        questData(quest: "Spend under $50 on groceries this week.", starNum: 3),
        questData(quest: "No new clothing purchases this month.", starNum: 2),
        questData(quest: "Spend less than $100 on entertainment this month.", starNum: 4),
        questData(quest: "No tech gadgets purchases this week.", starNum: 3),
        questData(quest: "Do not buy any fast food this week.", starNum: 3),
        questData(quest: "Spend under $30 on transportation this weekend.", starNum: 2),
        questData(quest: "Limit online shopping expenses to $50 this week.", starNum: 3),
        questData(quest: "Spend less than $20 on snacks this week.", starNum: 2),
        questData(quest: "Do not buy any non-essential items today.", starNum: 2),
        questData(quest: "Spend under $15 on hobbies this weekend.", starNum: 3),
        questData(quest: "Limit grocery shopping to once this week.", starNum: 4),
        questData(quest: "No spending on streaming services this week.", starNum: 2),
        questData(quest: "Only buy essentials during the next 3 days.", starNum: 3),
        questData(quest: "Do not buy drinks at bars this weekend.", starNum: 4)
    ]
    
    @State var questLimitAlert = false
    
    @Binding var activeQuests:[questData]
    @State var availableQuests:[questData] = []
    
    var body: some View {
        NavigationStack {
            VStack{
                List{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: 300, height: 55)
                        Text("Active Quests")
                            .font(.title)
                            .bold()
                        
                    }
                    
                    if activeQuests.count > 0{
                        ForEach(activeQuests, id: \.id) { quest in
                            CreateActiveQuest(quest: quest.quest, starNum: quest.starNum)
                        }
                    }else{
                        Text("You don't have any active quests yet :(")
                    }
                    
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: 300, height: 55)
                        Text("Available Quests")
                            .font(.title)
                            .bold()
                        
                    }
                    .onAppear{
                        updateAvailQ()
                    }
                    
                    ForEach(availableQuests, id:\.id) { quest in
                        ZStack{
                            VStack{
                                Text("\(quest.quest)")
                                    .frame(width: 270)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                
                                HStack{
                                    Text("\(quest.starNum)")
                                        .font(.system(size: 20))
                                        .padding(.top, 10)
                                        .foregroundColor(Color.black)
                                        .bold()
                                    Image(systemName: "star.fill")
                                        .symbolRenderingMode(.multicolor)
                                        .padding(.top, 7)
                                    
                                    
                                    Button("Start") {
                                        withAnimation{
                                            if(activeQuests.count < 4){
                                                availableQuests.remove(at: availableQuests.firstIndex(where: {$0.quest == quest.quest})!)
                                                activeQuests.append(questData(quest: quest.quest, starNum: quest.starNum))
                                                updateAvailQ()
                                            }else{
                                                questLimitAlert = true
                                            }
                                        }
                                    }
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 23))
                                    .frame(width: 90, height: 40)
                                    .background(Color.green)
                                    .cornerRadius(20)
                                    .padding(.leading, 10)
                                }
                            }
                        }
                    }
                    .alert("Quest Limit", isPresented: $questLimitAlert){
                        Button("Ok"){}
                    } message: {
                        Text("Complete your active quests to start new quests!")
                    }
                }
                
                
                
            }
            Spacer()
                .navigationTitle("Quests")
                .navigationBarTitleDisplayMode(.large)
        }
    }
    func updateAvailQ(){
        while(availableQuests.count < 5){
            var generating = true
            var randomQuest = questData(quest: "", starNum: 0)
            while(generating){
                randomQuest = Quests[Int.random(in: 0..<Quests.count)]
                
                let Contains = availableQuests.contains{ quest in
                    return quest.quest == randomQuest.quest
                }
                generating = Contains
                
            }
            availableQuests.append(randomQuest)
        }
    }
}
#Preview{
    QuestsView(activeQuests: .constant([]))
}



struct CreateActiveQuest: View {
    var quest: String
    var starNum: Int
    var body: some View {
        ZStack{
            
            VStack{
                Text("\(quest)")
                    .frame(width: 270)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                
                HStack{
                    Text("\(starNum)")
                        .font(.system(size: 20))
                        .padding(.top, 10)
                        .foregroundColor(Color.black)
                        .bold()
                    Image(systemName: "star.fill")
                        .symbolRenderingMode(.multicolor)
                        .padding(.top, 7)
                    
                }
                
                
            }
        }
    }
}
