//
//  ContentView.swift
//  Money Tree
//
//  Created by Avyan Mehra on 9/11/24.
//
import SwiftUI

struct ContentView: View {
    
    @State var activeQuests:[Quest] = []
    
    var body: some View {
        TabView{
            HomePage(activeQuests: $activeQuests)
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
            
            FinanceHome()
                .tabItem{
                    Label("Finance", systemImage: "dollarsign")
                }
            QuestsView(activeQuests: $activeQuests)
                .tabItem{
                    Label("Quest", systemImage: "book.closed.fill")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
