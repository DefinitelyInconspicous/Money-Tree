//
//  FinanceHome.swift
//  Money Tree
//
//  Created by Avyan Mehra on 11/11/24.
//
import SwiftUI
import Charts
import Forever

struct Expense: Identifiable, Decodable, Encodable, Equatable {
    var id = UUID()
    var amt: Double
    var time: Date
    var cat: String
    var timeact: Bool
}

struct MonthData: Identifiable, Decodable, Encodable {
    var id = UUID()
    var x: String
    var y: Double
}

struct CategoryBudget: Identifiable, Decodable, Encodable {
    var id = UUID()
    var cat: String
    var budget: Double
}

struct FinanceHome: View {
    @Forever("TimelineGraph") var timelineGraph: [MonthData] = [MonthData(x: "Jan", y: 0), MonthData(x: "Feb", y: 0), MonthData(x: "Mar", y: 0), MonthData(x: "Apr", y: 0), MonthData(x: "May", y: 0), MonthData(x: "Jun", y: 0), MonthData(x: "Jul", y: 0), MonthData(x: "Aug", y: 0), MonthData(x: "Sep", y: 0), MonthData(x: "Oct", y: 0), MonthData(x: "Nov", y: 0), MonthData(x: "Dec", y: 0)]
    
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
    
    @Forever("categoryBudgets") var categoryBudgets: [CategoryBudget] = [
        CategoryBudget(cat: "Food", budget: 500),
        CategoryBudget(cat: "Transport", budget: 300),
        CategoryBudget(cat: "Entertainment", budget: 200)
    ]
    
    @State private var expenseAdd = false
    @State private var selectedGraph = 0 // 0: Line Chart, 1: Bar Chart, 2: Pie Chart
    @State private var showBudgetSheet = false
    @State private var newCategoryName = ""
    @State private var newCategoryBudget: Double = 0.0
    @State private var showAddCategorySheet = false

    var body: some View {
            NavigationStack {
                VStack(spacing: 20) {
                    Picker("Select Graph", selection: $selectedGraph) {
                        Text("Yearly").tag(0)
                        Text("Monthly").tag(1)
                        Text("Categorised").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    if selectedGraph == 0 {
                        LineChartView()
                    } else if selectedGraph == 1 {
                        BarChartView()
                    } else {
                        PieChartView()
                    }
                    
                    Spacer()
                    
                    // View expenses button and list
                    VStack {
                        NavigationLink(destination: ExpensesList(expenseList: $expenseList)) {
                            HStack {
                                Text("View Expenses")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(.primary)
                                Image(systemName: "chevron.right")
                                    .imageScale(.large)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.primary)
                            }
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(15)
                        }
                        .padding(.top)
                        
                        if expenseList.count >= 3 {
                            ForEach(expenseList.suffix(2)) { item in
                                Button {
                                    if let index = expenseList.firstIndex(where: { $0.id == item.id }) {
                                        expenseList[index].timeact.toggle()
                                    }
                                } label: {
                                    VStack {
                                        HStack {
                                            Text(item.cat)
                                                .foregroundColor(.white)
                                                .fontWeight(.heavy)
                                            Spacer()
                                            Text("$" + String(format: "%.2f", item.amt))
                                                .foregroundColor(.white)
                                                .fontWeight(.heavy)
                                        }
                                        if item.timeact {
                                            Text(item.time.formatted())
                                                .foregroundColor(.white)
                                                .fontWeight(.medium)
                                        }
                                    }
                                    .padding()
                                    .background(Color.green)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .padding(.horizontal)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .navigationTitle("Finance")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        ToolbarItem() {
                            Button {
                                expenseAdd = true
                            } label: {
                                Image(systemName: "plus")
                                    .imageScale(.large)
                                    .fontWeight(.heavy)
                            }
                        }
                        ToolbarItem() {
                            Button {
                                showBudgetSheet = true
                            } label: {
                                Image(systemName: "pencil")
                                    .imageScale(.large)
                                    .fontWeight(.heavy)
                            }
                        }
                    }
                }
            }
        
        .sheet(isPresented: $expenseAdd) {
            AddExpense(expenseList: $expenseList)
        }
        .sheet(isPresented: $showBudgetSheet) {
            BudgetSheetView(categoryBudgets: $categoryBudgets)
        }
        .onAppear {
            updateTimelineGraph()
        }
        .onChange(of: expenseList) { _ in
            updateTimelineGraph()
        }
    }

    private func updateTimelineGraph() {
        var updatedGraph = [MonthData(x: "Jan", y: 0), MonthData(x: "Feb", y: 0), MonthData(x: "Mar", y: 0),
                            MonthData(x: "Apr", y: 0), MonthData(x: "May", y: 0), MonthData(x: "Jun", y: 0),
                            MonthData(x: "Jul", y: 0), MonthData(x: "Aug", y: 0), MonthData(x: "Sep", y: 0),
                            MonthData(x: "Oct", y: 0), MonthData(x: "Nov", y: 0), MonthData(x: "Dec", y: 0)]
        
        for expense in expenseList {
            let month = Calendar.current.component(.month, from: expense.time) - 1
            updatedGraph[month].y += expense.amt
        }
        
        timelineGraph = updatedGraph
    }
}

struct BudgetSheetView: View {
    @Binding var categoryBudgets: [CategoryBudget]
    @State private var newCategoryName: String = ""
    @State private var newCategoryBudget: Double = 0.0
    @State private var showAddCategorySheet = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(categoryBudgets) { budget in
                        HStack {
                            Text(budget.cat)
                                .fontWeight(.semibold)
                            Spacer()
                            TextField("Budget", value: .constant(budget.budget), formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                                .frame(width: 100)
                        }
                    }
                    .onDelete(perform: deleteCategory)
                }
                .listStyle(PlainListStyle())
                
                Button("Add Category") {
                    showAddCategorySheet.toggle()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Adjust Budget")
            .navigationBarItems(trailing: Button("Done") {
                categoryBudgets = categoryBudgets
            })
            .sheet(isPresented: $showAddCategorySheet) {
                AddCategorySheet(newCategoryName: $newCategoryName, newCategoryBudget: $newCategoryBudget, categoryBudgets: $categoryBudgets)
            }
        }
    }

    private func deleteCategory(at offsets: IndexSet) {
        categoryBudgets.remove(atOffsets: offsets)
    }
}

struct AddCategorySheet: View {
    @Binding var newCategoryName: String
    @Binding var newCategoryBudget: Double
    @Binding var categoryBudgets: [CategoryBudget]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Category Details")) {
                    TextField("Category Name", text: $newCategoryName)
                    TextField("Budget", value: $newCategoryBudget, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Button("Add Category") {
                    let newCategory = CategoryBudget(cat: newCategoryName, budget: newCategoryBudget)
                    categoryBudgets.append(newCategory)
                    newCategoryName = ""
                    newCategoryBudget = 0.0
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("Add Category")
            .navigationBarItems(trailing: Button("Cancel") {
                newCategoryName = ""
                newCategoryBudget = 0.0
            })
        }
    }
}


struct LineChartView: View {
    @Forever("TimelineGraph") var timelineGraph: [MonthData] = [MonthData(x: "Jan", y: 0), MonthData(x: "Feb", y: 0), MonthData(x: "Mar", y: 0), MonthData(x: "Apr", y: 0), MonthData(x: "May", y: 0), MonthData(x: "Jun", y: 0), MonthData(x: "Jul", y: 0), MonthData(x: "Aug", y: 0), MonthData(x: "Sep", y: 0), MonthData(x: "Oct", y: 0), MonthData(x: "Nov", y: 0), MonthData(x: "Dec", y: 0)]

    var body: some View {
        Chart {
            ForEach(timelineGraph, id: \.id) { item in
                LineMark(x: .value("Month", item.x), y: .value("Expenses", item.y))
            }
        }
        .frame(width: 300, height: 220)
        .padding()
    }
}

struct BarChartView: View {
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]

    var body: some View {
        let groupedData = Dictionary(grouping: expenseList) { expense in
            Calendar.current.component(.month, from: expense.time)
        }

        Chart {
            ForEach(Array(groupedData.keys.sorted()), id: \.self) { month in
                ForEach(groupedData[month]!, id: \.id) { expense in
                    BarMark(x: .value("Month", Calendar.current.monthSymbols[month - 1]), y: .value("Amount", expense.amt))
                        .foregroundStyle(by: .value("Category", expense.cat))
                }
            }
        }
        .frame(width: 300, height: 220)
        .padding()
    }
}

struct PieChartView: View {
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
    @Forever("categoryBudgets") var categoryBudgets: [CategoryBudget] = []

    var body: some View {
        let categoryTotals = expenseList.reduce(into: [String: Double]()) { result, expense in
            result[expense.cat, default: 0] += expense.amt
        }

        // Prepare the data for the pie chart
        let chartData = categoryTotals.map { category, total in
            PieChartDataEntry(value: total, label: category)
        }

        VStack {
            // Pie Chart
            Chart {
                ForEach(chartData, id: \.label) { entry in
                    SectorMark(
                        angle: .value("Amount", entry.value),
                        innerRadius: 50,
                        outerRadius: 100
                    )
                    .foregroundStyle(by: .value("Category", entry.label))
                }
            }
            .frame(width: 300, height: 220)
            .padding()

            // Labels below the chart
            HStack {
                ForEach(chartData, id: \.label) { entry in
                    VStack {
                        Text(entry.label)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text(String(format: "$ %.2f", entry.value))
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct PieChartDataEntry {
    let value: Double
    let label: String
}

