//
//  QuestsView.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI
import Forever

struct questData: Identifiable, Encodable, Decodable{
    var id = UUID()
    var starNum: Int
    var limit: Double
    var timeFor: Int
    var catagory: String
    
    func quest() -> String{
        return "\(limit == 0 ? "Do not spend":"Spend less than") \(limit != 0 ? "$\(Int(limit)).\(Int(String(limit).split(separator: ".")[1]) ?? 0) ":"")on \(catagory) \(timeFor == 1 ? "today":"for \(timeFor) days")"
    }
}

struct QuestsView: View {
    @State var Quests: [questData] = [
        questData(starNum: 1, limit: 30, timeFor: 1, catagory: "Food"),
        questData(starNum: 5, limit: 30, timeFor: 7, catagory: "Food"),
        questData(starNum: 1, limit: 0, timeFor: 7, catagory: "Shopping"),
        questData(starNum: 1, limit: 60, timeFor: 30, catagory: "Clothes"),
        questData(starNum: 3, limit: 50, timeFor: 2, catagory: "Food"),
        questData(starNum: 4, limit: 100, timeFor: 30, catagory: "Entertainment"),
        questData(starNum: 3, limit: 0, timeFor: 7, catagory: "Food"),
        questData(starNum: 2, limit: 30, timeFor: 5, catagory: "Transportation"),
        questData(starNum: 3, limit: 50, timeFor: 7, catagory: "Shopping"),
        questData(starNum: 2, limit: 20, timeFor: 7, catagory: "Food"),
        questData(starNum: 4, limit: 50, timeFor: 14, catagory: "Food"),
        questData(starNum: 2, limit: 0, timeFor: 1, catagory: "Essentials"),
        questData(starNum: 3, limit: 15, timeFor: 2, catagory: "Entertainment"),
        questData(starNum: 4, limit: 0, timeFor: 7, catagory: "Essentials"),
        questData(starNum: 2, limit: 0, timeFor: 7, catagory: "Entertainment"),
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
        questData(starNum: 4, limit: 0, timeFor: 5, catagory: "Food"),
        questData(starNum: 2, limit: 5, timeFor: 7, catagory: "Entertainment"),
        questData(starNum: 2, limit: 0, timeFor: 2, catagory: "Shopping"),
        questData(starNum: 5, limit: 0, timeFor: 30, catagory: "Entertainment"),
        questData(starNum: 5, limit: 0, timeFor: 14, catagory: "Shopping"),
        questData(starNum: 4, limit: 150, timeFor: 30, catagory: "Food"),
        questData(starNum: 3, limit: 40, timeFor: 2, catagory: "Food"),
        questData(starNum: 3, limit: 0, timeFor: 7, catagory: "Essentials"),
        questData(starNum: 1, limit: 0, timeFor: 1, catagory: "Entertainment"),
        questData(starNum: 3, limit: 15, timeFor: 7, catagory: "Transportation"),
        questData(starNum: 2, limit: 0, timeFor: 2, catagory: "Shopping"),
        questData(starNum: 2, limit: 5, timeFor: 1, catagory: "Transportation"),
        questData(starNum: 3, limit: 0, timeFor: 5, catagory: "Shopping"),
        questData(starNum: 3, limit: 0, timeFor: 5, catagory: "Entertainment"),
        questData(starNum: 4, limit: 50, timeFor: 30, catagory: "Essentials"),
        questData(starNum: 2, limit: 20, timeFor: 7, catagory: "Essentials")
    ]
    
    @State var questLimitAlert = false
    
    @Binding var activeQuests:[questData]
    @Forever("availableQuests") var availableQuests:[questData] = []
    
    var body: some View {
        NavigationStack {
            VStack{
                List{
                    
                    Section(header: Text("Active Quests").bold().font(.system(size: 20))){
                        if activeQuests.count > 0{
                            ForEach(activeQuests, id: \.id) { quest in
                                ZStack{
                                    VStack{
                                        HStack{
                                            Text("\(quest.quest())")
                                                .frame(width: 270)
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                            
                                            Text("\(quest.starNum)")
                                                .font(.system(size: 21))
                                                .foregroundColor(Color.black)
                                                .bold()
                                            Image(systemName: "star.fill")
                                                .symbolRenderingMode(.multicolor)
                                        }
                                    }
                                }
                            }
                        }else{
                            Text("You don't have any active quests yet :(")
                        }
                    }
                    
                    
                    
                    Section(header: Text("Available Quests").bold().font(.system(size: 20))){
                        
                        ForEach(availableQuests, id:\.id) { quest in
                            ZStack{
                                VStack{
                                    HStack{
                                        Text("\(quest.quest())")
                                            .frame(width: 270)
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text("\(quest.starNum)")
                                            .font(.system(size: 21))
                                            .foregroundColor(Color.black)
                                            .bold()
                                        Image(systemName: "star.fill")
                                            .symbolRenderingMode(.multicolor)
                                    }
                                    Button{
                                        withAnimation{
                                            if(activeQuests.count < 4){
                                                availableQuests.remove(at: availableQuests.firstIndex(where: {$0.quest() == quest.quest()})!)
                                                activeQuests.append(questData(starNum: quest.starNum, limit: quest.limit, timeFor: quest.timeFor, catagory: quest.catagory))
                                                updateAvailQ()
                                            }else{
                                                questLimitAlert = true
                                            }
                                        }
                                    } label:{
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: .infinity, height: 30)
                                                .ignoresSafeArea()
                                            Text("Start")
                                                .bold()
                                                .foregroundStyle(.white)
                                            
                                        }
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
            }
            .onAppear{
                updateAvailQ()
                print(Quests[0].quest())
            }
            
            Spacer()
                .navigationTitle("Quests")
                .navigationBarTitleDisplayMode(.large)
        }
    }
    func updateAvailQ(){
        while(availableQuests.count < 5){
            var generating = true
            var randomQuest = questData(starNum: 0, limit: 0.0, timeFor: 0, catagory: "")
            while(generating){
                randomQuest = Quests[Int.random(in: 0..<Quests.count)]
                
                let Contains = availableQuests.contains{ quest in
                    return quest.quest() == randomQuest.quest()
                }
                generating = Contains
                print(randomQuest)
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
