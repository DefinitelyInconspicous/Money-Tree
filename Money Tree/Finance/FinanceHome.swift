//
//  FinanceHome.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI
import Charts
import Forever

struct Expense: Identifiable, Decodable, Encodable {
    var id = UUID()
    var amt: Double
    var time: Date
    var cat: String
    var timeact: Bool
}

struct MonthData: Identifiable, Decodable, Encodable {
    var id = UUID()
    var x: String
    var y: Double
}

struct FinanceHome: View {
    @Forever("TimelineGraph") var timelineGraph: [MonthData] = [MonthData(x: "Jan", y: 0),MonthData(x: "Feb", y: 0),MonthData(x: "Mar", y: 0),MonthData(x: "Apr", y: 0),MonthData(x: "May", y: 0),MonthData(x: "Jun", y: 0),MonthData(x: "Jul", y: 0),MonthData(x: "Aug", y: 0),MonthData(x: "Sep", y: 0),MonthData(x: "Oct", y: 0),MonthData(x: "Nov", y: 0),MonthData(x: "Dec", y: 0)]
    
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
    @State var expenseAdd = false
    var body: some View {
        NavigationStack {
            Button {
                
            } label: {
                VStack {
                    HStack {
                        Text("Timeline")
                            .font(.title3)
                            .fontWeight(.bold)
                        Image(systemName: "chevron.right")
                            .fontWeight(.heavy)
                    }
                    Chart {
                        ForEach(timelineGraph, id: \.id) { item in
                            LineMark(x: .value("Month", item.x), y: .value("Expenses", item.y))
                        }
                    }
                }
            }
                .frame(width: 300, height: 220 , alignment: .center)
                .padding()
                .padding()
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray4))
                        .shadow(radius: 10)
                )
                
                .padding(.horizontal)
            
            Spacer()
            VStack {
                NavigationLink(destination: ExpensesList()) {
                    HStack {
                        Text("View Expenses")
                            .font(.headline)
                            .padding()
                        Image(systemName: "chevron.right")
                            .imageScale(.large)
                            .fontWeight(.heavy)
                    }
                }
                if expenseList.count >= 3 {
                    ForEach($expenseList, id: \.id) { item in
                        var count = 3
                        if count != 0 {
                            Button {
                                item.wrappedValue.timeact.toggle()
                            } label: {
                                VStack {
                                    HStack {
                                        Text(item.wrappedValue.cat)
                                            .foregroundStyle(.white)
                                            .fontWeight(.heavy)
                                        Spacer()
                                        Text("\(round(item.wrappedValue.amt * 100) / 100)")
                                            .foregroundStyle(.white)
                                            .fontWeight(.heavy)
                                    }
                                    if (item.wrappedValue.timeact == true) {
                                        Text("\(item.wrappedValue.time.formatted())")
                                            .foregroundStyle(.white)
                                            .fontWeight(.medium)
                                        
                                    }
                                }
                                .padding()
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                            .onAppear {
                                count -= 1
                            }
                        }
                    }
                }
            }
            .navigationTitle("Finance")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem() {
                    Button {
                        expenseAdd = true
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .fontWeight(.heavy)
                    }
                }
            }
            
        }
        .sheet(isPresented: $expenseAdd) {
            AddExpense()
        }
        
    }
}

#Preview {
    FinanceHome()
}
