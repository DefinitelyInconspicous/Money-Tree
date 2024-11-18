//
//  AddExpense.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI
import Forever

struct AddExpense: View {
    @Forever("Categories") var categories: [String] = ["Food", "Clothes", "Utilities", "Shopping", "Entertainment", "Essentials", "Transportation"]
    @Binding var expenseList: [Expense]
    @State private var selCat = "Food"
    @State private var amount = ""
    @State private var date: Date = .now
    @State private var errorMessage: String? = nil
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selCat) {
                        ForEach(categories, id: \.self) { Text($0).tag($0) }
                    }
                }
                Section(header: Text("Amount")) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .onChange(of: amount) { _ in validateForm() }
                    if let errorMessage = errorMessage {
                        Text(errorMessage).font(.caption).foregroundColor(.red)
                    }
                }
                Section(header: Text("Date")) {
                    DatePicker("Select date", selection: $date, in: ...Date.now)
                        .onChange(of: date) { _ in validateForm() }
                }

                
            }
            
            Button("Add Expense", action: addExpense)
                .padding()
                .background(isFormInvalid ? Color.gray : Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(isFormInvalid)
            Spacer()
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture { UIApplication.shared.dismissKeyboard() }
        }
    }

    private var isFormInvalid: Bool {
        amount.isEmpty || Double(amount) == nil || (Double(amount) ?? 0) <= 0 || date > Date()
    }

    private func validateForm() {
        errorMessage = nil
        if amount.isEmpty || Double(amount) == nil {
            errorMessage = "Please enter a valid amount."
        } else if let expenseAmount = Double(amount), expenseAmount <= 0 {
            errorMessage = "Amount must be greater than 0."
        } else if date > Date() {
            errorMessage = "The selected date cannot be in the future."
        }
    }

    private func addExpense() {
        guard let expenseAmount = Double(amount), expenseAmount > 0 else {
            errorMessage = "Please enter a valid amount greater than 0."
            return
        }
        expenseList.append(Expense(amt: expenseAmount, time: date, cat: selCat, timeact: false))
        dismiss()
    }
}

extension UIApplication {
    func dismissKeyboard() {
        windows.first(where: { $0.isKeyWindow })?.endEditing(true)
    }
}

#Preview {
    AddExpense(expenseList: .constant([Expense(amt: 0, time: .now, cat: "", timeact: false)]))
}
