//
//  ContentView.swift
//  Money Tree
//
//  Created by Avyan Mehra on 9/11/24.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
        }
        TabView{
            HomePage()
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
            
            FinanceHome()
                .tabItem{
                    Label("Finance", systemImage: "dollarsign")
                }
            ExpensesList()
                .tabItem{
                    Label("Quest", systemImage: "book.closed.fill")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
