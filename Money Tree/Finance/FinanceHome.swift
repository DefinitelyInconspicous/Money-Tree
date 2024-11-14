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

struct FinanceHome: View {
    @Forever("TimelineGraph") var timelineGraph: [MonthData] = [MonthData(x: "Jan", y: 0), MonthData(x: "Feb", y: 0), MonthData(x: "Mar", y: 0), MonthData(x: "Apr", y: 0), MonthData(x: "May", y: 0), MonthData(x: "Jun", y: 0), MonthData(x: "Jul", y: 0), MonthData(x: "Aug", y: 0), MonthData(x: "Sep", y: 0), MonthData(x: "Oct", y: 0), MonthData(x: "Nov", y: 0), MonthData(x: "Dec", y: 0)]
    
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
    
    @State private var expenseAdd = false
    @State private var selectedGraph = 0 // 0: Line Chart, 1: Bar Chart, 2: Pie Chart

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Graph", selection: $selectedGraph) {
                    Text("Yearly").tag(0)
                    Text("Monthly").tag(1)
                    Text("Categorised").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

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
                            Image(systemName: "chevron.right")
                                .imageScale(.large)
                                .fontWeight(.heavy)
                        }
                    }
                    if expenseList.count >= 3 {
                        ForEach(expenseList.suffix(3)) { item in
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
                                        Text(String(format: "%.2f", item.amt))
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
                }
            }
        }
        .sheet(isPresented: $expenseAdd) {
            AddExpense(expenseList: $expenseList)
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
                }
            }
        }
        .frame(width: 300, height: 220)
        .padding()
    }
}

struct PieChartView: View {
    @Forever("expenseList") var expenseList: [Expense] = [Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false), Expense(amt: 0, time: .now, cat: "Sample", timeact: false)]
    
    var body: some View {
        let categoryTotals = expenseList.reduce(into: [String: Double]()) { result, expense in
            result[expense.cat, default: 0] += expense.amt
        }
        
        Chart {
            ForEach(categoryTotals.keys.sorted(), id: \.self) { category in
                if let total = categoryTotals[category] {
                    SectorMark(angle: .value("Amount", total), innerRadius: 50, outerRadius: 100)
                        .foregroundStyle(by: .value("Category", category))
                }
            }
        }
        .frame(width: 300, height: 220)
        .padding()
    }
}

#Preview {
    FinanceHome()
}
