//
//  QuestsView.swift
//  Money Tree
//
//  Created by T Krobot on 11/11/24.
//

import SwiftUI

struct QuestsView: View {
    var active: Bool = false
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
                    
                    
                    CreateActiveQuest(quest: "Do not spend more than $30 on food today.", starNum: 1)
                    
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: 300, height: 55)
                        Text("Available Quests")
                            .font(.title)
                            .bold()
                        
                    }
                    CreateAvailableQuest(quest: "Do not spend more than $30 on food this week.", starNum: 5)
                        CreateAvailableQuest(quest: "Don’t online shop this week", starNum: 1)
                        CreateAvailableQuest(quest: "Spend less than $60 on clotes this month.", starNum: 1)
                }
                
                
                
            }
            Spacer()
            
                .navigationTitle("Quests")
                .navigationBarTitleDisplayMode(.large)
            
        }
    }
}
#Preview{
    QuestsView()
    
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


struct CreateAvailableQuest: View {
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
                    
                    
                    Button("Start") {
                        print("Start")
                    }.foregroundColor(Color.white)
                        .font(.system(size: 23))
                        .frame(width: 90, height: 40)
                        .background(Color.green)
                        .cornerRadius(20)
                        .padding(.leading, 10)
                    
                    
                }
                
                
            }
        }
    }
}

