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
    
    @Forever("expenseList") var expenseList: [Expense] = []
    
    @Forever("categoryBudgets") var categoryBudgets: [CategoryBudget] = [
        CategoryBudget(cat: "Food", budget: 500),
        CategoryBudget(cat: "Transport", budget: 300),
        CategoryBudget(cat: "Entertainment", budget: 200),
        CategoryBudget(cat: "Clothes", budget: 100),
        CategoryBudget(cat: "Utilities", budget: 400),
        CategoryBudget(cat: "Shopping", budget: 200),
        CategoryBudget(cat: "Essentials", budget: 100),
        CategoryBudget(cat: "Entertainment", budget: 200),
        CategoryBudget(cat: "Transportation", budget: 50)
    ]
    
    @State private var expenseAdd = false
    @State private var selectedGraph = 0 // 0: Line Chart, 1: Bar Chart, 2: Pie Chart
    @State private var showBudgetSheet = false
    @State private var listOpacity: Double = 1.0 // For list fade animation
    
    func deleteItems(at offsets: IndexSet) {
        withAnimation {
            expenseList.remove(atOffsets: offsets)
        }
    }
    
    var body: some View {
        
        NavigationStack {
            List {
                    Section {
                        VStack(spacing: 20) {
                            Picker("Select Graph", selection: $selectedGraph) {
                                Text("Trend").tag(0)
                                Text("Yearly").tag(1)
                                Text("Monthly").tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.horizontal)
                            .padding(.top, 20)
                            
                            TabView(selection: $selectedGraph) {
                                LineChartView()
                                    .tag(0)
                                    .transition(.opacity)
                                BarChartView()
                                    .tag(1)
                                    .transition(.opacity)
                                PieChartView()
                                    .tag(2)
                                    .transition(.opacity)
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: 400)
                            .animation(.easeInOut, value: selectedGraph)
                            
                        }
                    }
                    
                Section(header: Text("Expenses")) {
                    
                    ForEach($expenseList, id: \.id) { item in
                        
                        HStack {
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    item.wrappedValue.timeact.toggle()
                                }
                            } label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(item.wrappedValue.cat)
                                            .foregroundColor(.primary)
                                            .fontWeight(.semibold)
                                        Text(item.wrappedValue.time.formatted())
                                            .foregroundColor(.gray)
                                            .fontWeight(.medium)
                                            .font(.caption)
                                        Spacer()
                                        Text("$\(String(format: "%.2f", item.wrappedValue.amt))")
                                            .foregroundColor(.primary)
                                            .fontWeight(.semibold)
                                    }
                                    
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .frame(maxHeight: .infinity)
                    .opacity(listOpacity)
                    .animation(.easeInOut(duration: 0.3), value: listOpacity)
                }
            }
            .navigationTitle("Finance")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem() {
                    Button {
                        withAnimation {
                            expenseAdd = true
                        }
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .fontWeight(.heavy)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            showBudgetSheet = true
                        }
                    } label: {
                        Image(systemName: "pencil")
                            .imageScale(.large)
                            .fontWeight(.heavy)
                    }
                }
            }
            
            .background(Color(.systemGray6))
            
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
            withAnimation {
                listOpacity = 0.5
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    listOpacity = 1.0
                }
            }
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
    @Environment(\.dismiss) var dismiss // This will dismiss the sheet
    
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
                dismiss()
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
    @Forever("TimelineGraph") var timelineGraph: [MonthData] = [
        MonthData(x: "Jan", y: 0), MonthData(x: "Feb", y: 0), MonthData(x: "Mar", y: 0),
        MonthData(x: "Apr", y: 0), MonthData(x: "May", y: 0), MonthData(x: "Jun", y: 0),
        MonthData(x: "Jul", y: 0), MonthData(x: "Aug", y: 0), MonthData(x: "Sep", y: 0),
        MonthData(x: "Oct", y: 0), MonthData(x: "Nov", y: 0), MonthData(x: "Dec", y: 0)
    ]
    
    @State var startDate = Calendar.current.date(byAdding: .month, value: -6, to: Date())!
    @State var endDate = Date()
    
    var body: some View {
        VStack {
            VStack {
                DatePicker("Start", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                DatePicker("End", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
            }
            .padding()
            Chart {
                ForEach(filteredTimelineGraph(), id: \.id) { item in
                    LineMark(x: .value("Month", item.x), y: .value("Expenses", item.y))
                }
            }
           
            .padding()
        }
    }
    
    func filteredTimelineGraph() -> [MonthData] {
        return timelineGraph.filter { item in
            guard let monthDate = monthToDate(month: item.x) else { return false }
            return monthDate >= startDate && monthDate <= endDate
        }
    }
    
    func monthToDate(month: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        let formattedString = "\(month) \(Calendar.current.component(.year, from: Date()))"
        return dateFormatter.date(from: formattedString)
    }
}

struct BarChartView: View {
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
    
    var body: some View {
        let groupedData = Dictionary(grouping: expenseList) { expense in
            Calendar.current.component(.month, from: expense.time)
        }
        let monthlyTotals = groupedData.mapValues { expenses in
            expenses.reduce(0) { $0 + $1.amt }
        }
        
        Chart {
            ForEach(Array(monthlyTotals.keys.sorted()), id: \.self) { month in
                BarMark(x: .value("Month", Calendar.current.monthSymbols[month - 1]), y: .value("Amount", monthlyTotals[month]!))
            }
        }
        .frame(width: 300, height: 220)
        .padding()
    }
}

struct PieChartView: View {
    @Forever("expenseList") var expenseList: [Expense] = [
        Expense(amt: 0, time: .now, cat: "Sample", timeact: false),
        Expense(amt: 0, time: .now, cat: "Sample", timeact: false),
        Expense(amt: 0, time: .now, cat: "Sample", timeact: false)
    ]
    @Forever("categoryBudgets") var categoryBudgets: [CategoryBudget] = []
    
    var body: some View {
        let categoryTotals = expenseList.reduce(into: [String: Double]()) { result, expense in
            result[expense.cat, default: 0] += expense.amt
        }

        let chartData = categoryTotals.map { category, total in
            PieChartDataEntry(value: total, label: category)
        }
        
        VStack {
            // Pie chart
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
            
            // Labels with budgets below the chart
            HStack {
                ForEach(chartData, id: \.label) { entry in
                    let budget = categoryBudgets.first(where: { $0.cat == entry.label })?.budget ?? 0.0
                    VStack {
                        Text(entry.label)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Text("Spent: \(String(format: "$%.2f", entry.value))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text("Budget: \(String(format: "$%.2f", budget))")
                            .font(.footnote)
                            .foregroundColor(entry.value > budget ? .red : .green)
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
