//
//  AddExpense.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI
import Forever

struct AddExpense: View {
    @Forever(wrappedValue: ["Food", "Clothes", "Utilities", "Shopping"], "Categories") var categories: [String]
    @State var selCat = "Food"
    @State var total = Double(00.00)
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(String(total))
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Add")
                            .padding()
                            .fontWeight(.heavy)
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .padding()
                }
                HStack {
                    HStack {
                        Spacer()
                        Picker("Category", selection: $selCat) {
                            ForEach(categories, id: \.self) { cat in
                                HStack{
                                    Text(cat)
                                }
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        .frame(height: 100)
                        Spacer()
                    }
                    .accentColor(.black)
                    .fontWeight(.medium)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    NavigationLink {
                        
                    } label: {
                        
                    }
                }
                VStack {
                    HStack {
                        
                    }
                }
                Spacer()
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddExpense()
}
