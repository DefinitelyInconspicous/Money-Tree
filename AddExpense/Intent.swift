//
//  Intent.swift
//  Money Tree
//
//  Created by Avyan Mehra on 16/11/24.
//

import Foundation
import AppIntents
import Forever

enum MyError: Error {
    case expenseSavingFailed
}

@available(iOS 17.0, macOS 14.0, watchOS 10.0, *)
struct AddExpenseIntent: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "AddExpenseIntent"
    

    static var title: LocalizedStringResource = "Add Expense"
    static var description = IntentDescription("Add a new expense to your list by specifying the category, amount, and date.")

    @Parameter(title: "Category", default: "General")
    var category: String

    @Parameter(title: "Amount", default: 0.0)
    var amount: Double

    @Parameter(title: "Date", default: .now)
    var date: Date?

    static var parameterSummary: some ParameterSummary {
        Summary("Add an expense of \(\.$amount) to \(\.$category) on \(\.$date)")
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$category, \.$amount, \.$date)) { category, amount, date in
            DisplayRepresentation(
                title: "Add Expense",
                subtitle: "Expense of $\(String(format: "%.2f", amount)) to \(category) on \(date?.formatted() ?? "Now")"
            )
        }
    }

    func perform() async throws -> some IntentResult {
        if saveExpense(category: category, amount: amount, date: date ?? .now) {
            return .result(dialog: "Expense of $\(String(format: "%.2f", amount)) added to \(category) on \(date?.formatted() ?? "Now").")
        } else {
            throw MyError.expenseSavingFailed
        }
    }

    private func saveExpense(category: String, amount: Double, date: Date) -> Bool {
        @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
        let newExpense = Expense(id: UUID(), amt: amount, time: date, cat: category, timeact: false)
        expenseList.append(newExpense)
        return true
    }
}


@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static var CategoryParameterPrompt: Self {
        "Choose a category to add your expense to."
    }
    static func CategoryParameterDisambiguationIntro(count: Int, category: String) -> Self {
        "There are \(count) options matching ‘\(category)’."
    }
    static func CategoryParameterConfirmation(category: String) -> Self {
        "Just to confirm, you wanted ‘\(category)’?"
    }
    static func AmountParameterPrompt(category: String) -> Self {
        "How much did you spend on \(category)?"
    }
    static func AmountParameterDisambiguationIntro(count: Int, amount: Double) -> Self {
        "There are \(count) options matching ‘\(amount)’."
    }
    static func AmountParameterConfirmation(amount: Double) -> Self {
        "Just to confirm, you wanted \(String(format: "%.2f", amount))?"
    }
    static func DateParameterPrompt(amount: Double, category: String) -> Self {
        "When did you spend \(String(format: "%.2f", amount)) on \(category)?"
    }
    static func DateParameterDisambiguationIntro(count: Int, date: Date) -> Self {
        "There are \(count) options matching \(date.formatted())."
    }
    static func DateParameterConfirmation(date: Date) -> Self {
        "Just to confirm, you wanted \(date.formatted())?"
    }
}

