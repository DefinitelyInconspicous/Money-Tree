//
//  Variables.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//

import Foundation
import Forever


@Forever(wrappedValue: [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)], "expenseList") var expenseList: [Expense]
