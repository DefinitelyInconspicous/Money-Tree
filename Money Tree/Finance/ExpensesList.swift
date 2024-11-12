//
//  ExpensesList.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI
import Forever



struct ExpensesList: View {
    @Forever(wrappedValue: [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)], "expenseList") var expenseList: [Expense]
    @State var expenseAdd = false
    var body: some View {
        NavigationStack {
            List {
                ForEach($expenseList, id: \.id) { item in
                    var count = 3
                    if count != 0 {
                        HStack {
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
                                            .animation(.easeInOut)
                                        
                                    } //unskibidi not js!!!!! kys!!
                                }
                            }
                            .buttonStyle(.plain)
                            .onAppear {
                                count -= 1
                            }
                        }
                    }
                }
                
                
            }
            .navigationTitle("Expenses")
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
    ExpensesList()
}
// avyan i hate you kys
