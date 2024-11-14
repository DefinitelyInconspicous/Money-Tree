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
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
    @State var selCat = "Food"
    @State var amount = ""
    @State var date: Date = .now
    var body: some View {
       NavigationStack {
            List {
                Section {
//                    Picker("Category", selection: $selCat) {
//                        ForEach(categories, id: \.self) { cat in
//                            HStack{
//                                Text(cat)
//                            }
//                        }
//                    }
//                    TextField("Amount", text: $amount)
//                        .keyboardType(.numberPad)
//                        .padding()
                    
                    DatePicker("Date", selection: $date)
//                    Button {
//                        expenseList.append(Expense(amt: Double(amount)!, time: date, cat: selCat, timeact: false))
//                    } label: {
//                        Text("Add Expense")
//                    }
//                    
                    
                }
                
            }
            
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    AddExpense()
}
