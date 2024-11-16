//
//  ContentView.swift
//  Money Tree
//
//  Created by Avyan Mehra on 9/11/24.
//
import SwiftUI

struct ContentView: View {
    
    @State var activeQuests:[questData] = []
    @State var TabViewSelection = 0
    
    var body: some View {
        TabView(selection: $TabViewSelection){
            HomePage(activeQuests: $activeQuests, TabViewSelection: $TabViewSelection)
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
                .tag(1)
            
            FinanceHome()
                .tabItem{
                    Label("Finance", systemImage: "dollarsign")
                }
                .tag(2)
            QuestsView(activeQuests: $activeQuests)
                .tabItem{
                    Label("Quest", systemImage: "book.closed.fill")
                }
                .tag(3)
            
        }
    }
}

#Preview {
    ContentView()
}
