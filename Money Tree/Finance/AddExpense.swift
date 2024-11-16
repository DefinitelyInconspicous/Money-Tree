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
    @State var selCat = "Food"
    @State var amount = ""
    @State var date: Date = .now
    @State private var errorMessage: String? = nil
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                // Category Picker Section
                Section(header: Text("Category").font(.headline)) {
                    Picker("Category", selection: $selCat) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                // Amount Input Section
                Section(header: Text("Amount").font(.headline)) {
                    TextField("Enter amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 10)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 5)
                    }
                }

                // Date Picker Section
                Section(header: Text("Date").font(.headline)) {
                    DatePicker("Select date", selection: $date, in: ...Date.now, displayedComponents: .date)
                        .datePickerStyle(DefaultDatePickerStyle())
                        .padding(.vertical, 10)
                }

                // Add Expense Button
                Section {
                    Button{
                        errorMessage = nil
                        
                        if let expenseAmount = Double(amount), expenseAmount > 0, date <= Date() {
                            let newExpense = Expense(amt: expenseAmount, time: date, cat: selCat, timeact: false)
                            expenseList.append(newExpense)
                            print("Expense added: \(newExpense)") // Debug statement
                            dismiss()
                        } else {
                            if let expenseAmount = Double(amount), expenseAmount <= 0 {
                                errorMessage = "Please enter a valid amount greater than 0."
                            } else if date > Date() {
                                errorMessage = "The date cannot be in the future."
                            }
                        }
                    } label:{
                        Text("Add Expense")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.green)
                            .opacity(isFormInvalid ? 0.7 : 1)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.vertical)
                    }
                    .disabled(isFormInvalid)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
        }
    }

    private var isFormInvalid: Bool {
        return amount.isEmpty || Double(amount) == nil || Double(amount) == 0 || date > Date()
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
