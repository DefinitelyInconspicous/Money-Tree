//
//  AddExpense.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI
import Forever

struct AddExpense: View {
    @Forever("Categories") var categories: [String] = ["Food", "Clothes", "Utilities", "Shopping"]
    @Binding var expenseList: [Expense]
    @State var selCat = "Food"
    @State var amount = ""
    @State var date: Date = .now
    @Environment(\.dismiss) var dismiss

    var body: some View {
       NavigationStack {
            List {
                Section {
                    Picker("Category", selection: $selCat) {
                        ForEach(categories, id: \.self) { cat in
                            HStack{
                                Text(cat)
                            }
                        }
                    }
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .padding()
                    
                    DatePicker("Date", selection: $date)
                    Button {
                        expenseList.append(Expense(amt: Double(amount) ?? 0, time: date, cat: selCat, timeact: false))
                        dismiss()
                    } label: {
                        Text("Add Expense")
                    }
                    
                    
                }
                
            }
            
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    AddExpense(expenseList: .constant([Expense(amt: 0, time: .now, cat: "", timeact: false)]))
}
