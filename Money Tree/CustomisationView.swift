//
//  CustomisationView.swift
//  Money Tree
//
//  Created by T Krobot on 15/11/24.
//
import SwiftUI

struct CustomisationView: View {
    @Binding var stars: Int  // Binding to reflect the stars from the HomePage
    @State private var selectedCategory: String = "Pot"
    let categories = ["Pot", "Soil", "Plant"]
    
    // Updated items with correct asset names
    let potImages = ["Starting Pot", "pot2", "pot3", "pot4", "pot5", "pot6", "pot7", "pot8", "pot9", "pot10", "pot11"]
    let soilImages = ["soil1", "soil2", "soil3", "soil4"]
    let plantImages = ["plant", "plant2", "plant3", "plant4"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                HStack {
                    Spacer()
                    Text("\(stars)")
                        .font(.largeTitle)
                        .bold()
                    Image(systemName: "star.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.largeTitle)
                        .shadow(color: Color("Gold"), radius: 2, y: 2)
                }
                .padding(.top, 10)
                .padding(.trailing, 20)
                .offset(y:50)
                
               
               
                Image("currentTree")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.top, 20)
                
                // Dropdown to select category
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(MenuPickerStyle()) // Displays as dropdown
                .padding()
                .background(Color.green.opacity(0.3))
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .center)
                
                // Show options based on the selected category
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 15) {
                    ForEach(currentOptions(), id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .padding()
                            .frame(width: 100, height: 100)
                            .border(Color.green, width: 10)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Customise Tree")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // Helper function to return options based on selected category
    func currentOptions() -> [String] {
        switch selectedCategory {
        case "Pot":
            return potImages
        case "Soil":
            return soilImages
        case "Plant":
            return plantImages
        default:
            return []
        }
    }
}
#Preview {
    CustomisationView(stars: .constant(0))
}
