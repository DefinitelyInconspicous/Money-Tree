
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
                            .offset(x: 150, y:20)
                            .bold()
                        Image(systemName: "star.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.largeTitle)
                            .offset(x: 150, y:20)
                            .shadow(color: Color("Gold"), radius: 50, y: 5)
                        
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.large)
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 380, height: 400)
                            .foregroundColor(Color.gray.opacity(0.4))
                        
                        ZStack{
                            Image("blackpot")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 600, height: 600)
                            
                            Image("level1plant")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 600, height: 600)
                            
                            Image("brownsoil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 600, height: 600)
                            
                        }.offset(y:100)
                        
                        
                    }.offset(y:-80)
                    
                    
                }
                Text("Active Quests")
                    .font(.largeTitle)
                    .bold()
                    .offset(x:-70, y:-170)
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.green)
                        .frame(width: 300, height: 100)
                    VStack{
                        Text("Do not spend more than $30 on food today")
                            .frame(width: 270)
                            .foregroundColor(Color.white)
                            .bold()
                        
                        
                        HStack{
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
                }.offset(y:-150)
            }
            
            
        }
    }
}

#Preview {
    HomePage()
}
