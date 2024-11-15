//
//  ExpensesList.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI
import Forever

struct ExpensesList: View {
    @Binding var expenseList: [Expense]
    
    @State private var expenseAdd = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($expenseList, id: \.id) { item in
                    HStack {
                        Button {
                            item.wrappedValue.timeact.toggle()
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(item.wrappedValue.cat)
                                        .foregroundColor(.primary)
                                        .fontWeight(.heavy)
                                    Text(item.wrappedValue.time.formatted())
                                        .foregroundColor(.gray)
                                        .fontWeight(.medium)
                                        .font(.caption)
                                        .animation(.easeInOut, value: item.wrappedValue.timeact)
                                    Spacer()
                                    Text("$\(String(format: "%.2f", item.wrappedValue.amt))")
                                        .foregroundColor(.primary)
                                        .fontWeight(.heavy)
                                }
                                    
                                
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem {
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
            AddExpense(expenseList: $expenseList)
        }
    }
    
     func deleteItems(at offsets: IndexSet) {
        expenseList.remove(atOffsets: offsets)
    }
}

#Preview {
    ExpensesList(expenseList: .constant([
        Expense(amt: 50, time: .now, cat: "Food", timeact: false),
        Expense(amt: 75, time: .now, cat: "Transport", timeact: true),
        Expense(amt: 20, time: .now, cat: "Entertainment", timeact: false)
    ]))
}
