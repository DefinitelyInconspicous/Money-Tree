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
    
    @State var temp50 = 0
    @State var temp10 = 0
    @State var temp5 = 0
    @State var temp1 = 0
    @State var total = 0
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("$" + String(total))
                        .fontWeight(.heavy)
                        .font(.title)
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
                        Text("$50")
                            .foregroundStyle(.white)
                            .padding()
                            .fontWeight(.black)
                            .frame(width: 200, height: 100)
                            .background(.cyan)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                        Spacer()
                        Stepper("", value: $temp50, in: 0...10000000)
                            .padding()
                            .onChange(of: temp50) {
                                total = 50*temp50 + 10*temp10 + 5*temp5 + 1*temp1
                            }
                            
                    }
                    HStack {
                        Text("$10")
                            .foregroundStyle(.white)
                            .padding()
                            .fontWeight(.black)
                            .frame(width: 200, height: 100)
                            .background(.pink)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                        Spacer()
                        Stepper("", value: $temp10, in: 0...10000000)
                            .padding()
                            .onChange(of: temp10) {
                                total = 50*temp50 + 10*temp10 + 5*temp5 + 1*temp1
                            }
                            
                    }
                    HStack {
                        Text("$5")
                            .foregroundStyle(.white)
                            .padding()
                            .fontWeight(.black)
                            .frame(width: 200, height: 100)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                        Spacer()
                        Stepper("", value: $temp5, in: 0...10000000)
                            .padding()
                            .onChange(of: temp5) {
                                total = 50*temp50 + 10*temp10 + 5*temp5 + 1*temp1
                            }
                            
                    }
                    HStack {
                        Text("$1")
                            .foregroundStyle(.black)
                            .padding()
                            .fontWeight(.black)
                            .frame(width: 200, height: 100)
                            .background(.yellow)
                            .clipShape(Circle())
                            .padding()
                        Spacer()
                        Stepper("", value: $temp1, in: 0...10000000)
                            .padding()
                            .onChange(of: temp1) {
                                total = 50*temp50 + 10*temp10 + 5*temp5 + 1*temp1
                            }
                            
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
