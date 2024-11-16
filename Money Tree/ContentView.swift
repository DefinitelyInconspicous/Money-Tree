//
//  ContentView.swift
//  Money Tree
//
//  Created by Avyan Mehra on 9/11/24.
//
import SwiftUI
import Forever
import UserNotifications

struct ContentView: View {
    
    @Forever("stars") var stars: Int = 0
    @Forever("activeQuests") var activeQuests: [questData] = []
    @Forever("availableQuests") var availableQuests: [questData] = []
    @Forever("expenseList") var expenseList: [Expense] = []
    
    @State private var prevDay = Date.now
    
    private let notifCentre = UNUserNotificationCenter.current()
    @State private var authorisationStatus: UNAuthorizationStatus = .notDetermined
    
    var body: some View {
        TabView{
            HomePage(stars: $stars, activeQuests: $activeQuests)
                .tabItem{
                    Label("Home", systemImage: "house.fill")
                }
            FinanceHome()
                .tabItem{
                    Label("Finance", systemImage: "dollarsign")
                }
            QuestsView(availableQuests: $availableQuests, activeQuests: $activeQuests, stars: $stars)
                .tabItem{
                    Label("Quest", systemImage: "book.closed.fill")
                }
        }
        .onAppear{
            //Notification
            notifCentre.removeAllDeliveredNotifications()
            
            var PurchaseLogAdded = false
            var StartQuestAdded = false
            notifCentre.getPendingNotificationRequests{requests in
                for request in requests{
                    if request.identifier == "PurchaseLog"{
                        PurchaseLogAdded = true
                    }
                    if request.identifier == "StartQuest"{
                        StartQuestAdded = true
                    }
                }
            }
            if !PurchaseLogAdded{
                addPurchaseNotif()
            }
            if !StartQuestAdded{
                addStartQuestNotif()
            }
            
            
            
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
        .onChange(of: expenseList){ _, _ in
            //Update Amount Left
            let expense = expenseList.last
            
            for i in 0..<activeQuests.count{
                if (activeQuests[i].catagory == expense!.cat){
                    activeQuests[i].limit -= expense!.amt
                    if activeQuests[i].limit < 0{
                        activeQuests[i].status = false
                        notifCentre.removePendingNotificationRequests(withIdentifiers: ["QuestComplete\(activeQuests[i].id)"])
                    }
                }
            }
            
            
            //Notification
            if expense?.cat == "Food"{
                notifCentre.removePendingNotificationRequests(withIdentifiers: ["Food"])
                addFoodNotif()
            }
            notifCentre.removePendingNotificationRequests(withIdentifiers: ["PurchaseLog"])
        }
        .onChange(of: activeQuests){ _, _ in
            //Notification
            if activeQuests.count == 4{
                notifCentre.removePendingNotificationRequests(withIdentifiers: ["StartQuest"])
            }else{
                notifCentre.removePendingNotificationRequests(withIdentifiers: ["StartQuest"])
                addStartQuestNotif()
            }
        }
    }
    func addFoodNotif(){
        let content = UNMutableNotificationContent()
        content.title = "We know you have eaten."
        content.body  = "Log your food expenses!"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)
        notifCentre.add(UNNotificationRequest(identifier: "Food", content: content, trigger: trigger))
    }
    func addPurchaseNotif(){
        let content = UNMutableNotificationContent()
        content.title = "Log your purchases!"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5760, repeats: true)
        notifCentre.add(UNNotificationRequest(identifier: "PurchaseLog", content: content, trigger: trigger))
    }
    func addQuestCompleteNotif(quest: questData){
        let content = UNMutableNotificationContent()
        content.title = "Quest Compelte!"
        content.body = "Claim your rewards!"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(quest.timeFor*24*60), repeats: true)
        notifCentre.add(UNNotificationRequest(identifier: "QuestComplete\(quest.id)", content: content, trigger: trigger))
    }
    func addStartQuestNotif(){
        let content = UNMutableNotificationContent()
        content.title = "Start Another Quest!"
        content.body  = "Your plant needs to grow!"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)
        notifCentre.add(UNNotificationRequest(identifier: "StartQuest", content: content, trigger: trigger))
    }
}

#Preview {
    ContentView()
}
