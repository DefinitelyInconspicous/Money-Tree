//
//  FinanceHome.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import SwiftUI

struct FinanceHome: View {
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("View Expenses")
                        .font(.headline)
                        .padding()
                    NavigationLink(destination: ExpensesList()) {
                        Text("View Expenses")
                    }
                    
                }
            }
            .navigationTitle("Finance")
        }
    }
}

#Preview {
    FinanceHome()
}
