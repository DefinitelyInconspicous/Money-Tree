//
//  AddExpense.swift
//  AddExpense
//
//  Created by Avyan Mehra on 16/11/24.
//

import AppIntents

struct AddExpense: AppIntent {
    static var title: LocalizedStringResource { "AddExpense" }
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
