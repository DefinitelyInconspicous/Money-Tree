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
    @State var selCat = "Food"
    @State var amount = "0"
    @State var date: Date = .now
    var body: some View {
        NavigationStack {
            Form {
                Picker("Category", selection: $selCat) {
                    ForEach(categories, id: \.self) { cat in
                        HStack{
                            Text(cat)
                        }
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                    .padding()
                
                DatePicker("Date", selection: $date)
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Add Expense")
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    Spacer()
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
