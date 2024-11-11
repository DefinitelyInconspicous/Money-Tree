//
//  FinanceHome.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI
import Forever

struct Expense: Identifiable, Decodable, Encodable {
    var id = UUID()
    var amt: Double
    var time: Date
    var cat: String
    var timeact: Bool
}

struct data: Identifiable, Decodable, Encodable {
    var id = UUID()
    var x: Double
    var y: Double
}

struct FinanceHome: View {
    @Forever(wrappedValue: [data(x: 1, y: 0),data(x: 2, y: 0),data(x: 3, y: 0),data(x: 4, y: 0),data(x: 5, y: 0),data(x: 6, y: 0),data(x: 7, y: 0),data(x: 8, y: 0),data(x: 9, y: 0),data(x: 10, y: 0),data(x: 11, y: 0),data(x: 12, y: 0)], "TimelineGraph") var timelineGraph: [data]
    
    @Forever(wrappedValue: [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)], "expenseList") var expenseList: [Expense]
    var body: some View {
        NavigationStack {
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
                                    Text("\(round(item.wrappedValue.amt))")
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
            .navigationTitle("Finance")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    FinanceHome()
}
