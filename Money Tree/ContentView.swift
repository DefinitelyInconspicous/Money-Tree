//
//  ContentView.swift
//  Money Tree
//
//  Created by Avyan Mehra on 9/11/24.
//
import SwiftUI
import Forever

struct ContentView: View {
    
    @State var TabViewSelection = 0
    
    @Forever("expenseList") var expenseList:[Expense] = []
    @Forever("activeQuests") var activeQuests:[questData] = []
    @State private var prevDay = Date.now
    
    var body: some View {
        TabView(selection: $TabViewSelection){
            HomePage(TabViewSelection: $TabViewSelection)
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
                .tag(1)
            
            FinanceHome()
                .tabItem{
                    Label("Finance", systemImage: "dollarsign")
                }
                .tag(2)
            QuestsView()
                .tabItem{
                    Label("Quest", systemImage: "book.closed.fill")
                }
                .tag(3)
        }
        .onAppear{
            //Update days
            
            if let storedPrevDay = UserDefaults.standard.object(forKey: "PrevDay") as? Date{
                prevDay = storedPrevDay
            }else{
                print("first time")
                UserDefaults.standard.set(Date.now, forKey: "PrevDay")
            }
            
            let timeInterval = Calendar.current.dateComponents([.day], from: prevDay, to: Date.now)
            if timeInterval.day! > 0{
                for i in 0..<activeQuests.count{
                    activeQuests[i].timeFor -= 1
                }
            }
        }
        .onChange(of: expenseList){ old, new in
            let expense = expenseList.last
            
            for i in 0..<activeQuests.count{
                if (activeQuests[i].catagory == expense!.cat){
                    activeQuests[i].limit -= expense!.amt
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
