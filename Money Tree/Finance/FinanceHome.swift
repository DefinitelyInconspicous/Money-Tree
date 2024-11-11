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
                        .font(.title3)
                    NavigationLink(destination: ExpensesList()) {
                        Text("")
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
