//
//  ContentView.swift
//  Money Tree
//
//  Created by Avyan Mehra on 9/11/24.
//
import SwiftUI
import Forever

struct ContentView: View {
    
    @Forever("activeQuests") var activeQuests:[questData] = []
    @State var TabViewSelection = 0
    
    @State var firstOpened = true
    
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
        .onAppear{
            firstOpened = UserDefaults.standard.bool(forKey: "firstOpened") ?? true
            if firstOpened{
                UserDefaults.standard.set(Date.now, forKey: "firstOpenedDay")
                UserDefaults.standard.set(false, forKey: "firstOpened")
                print("hello")
            }else{
                print("nope")
            }
            print("onappear done")
        }
    }
}

#Preview {
    ContentView()
}
