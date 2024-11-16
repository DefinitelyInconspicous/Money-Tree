import SwiftUI

struct CustomisationView: View {
    @Binding var stars: Int  // Binding to reflect the stars from the HomePage
    @State private var selectedCategory: String = "Pot"
    @State private var isBuySheetPresented: Bool = false
    @State private var selectedItem: String? = nil
    @State private var selectedItemPrice: Int = 0
    let categories = ["Pot", "Soil", "Plant"]
    
   
    @State private var selectedPot: String = "Starting Pot"
    @State private var selectedSoil: String = "soil1"
    @State private var selectedPlant: String = "plant"
    
    let potImages = ["Starting Pot", "pot2","pot5", "pot11", "pot6", "pot8", "pot9","pot7", "pot3", "pot4"]
    let potPrices = [0, 10, 10, 10, 10, 10, 10, 15, 20, 25]
    
    let soilImages = ["soil1", "soil2", "soil3", "soil4"]
    let soilPrices = [0, 5, 10, 15]
    
    let plantImages = ["plant", "plant2", "plant3", "plant4"]
    let plantPrices = [0, 20, 25, 30]
    
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
                
                
                Text("Customise Your Tree")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 20)
                
                
                ZStack {
                    Image(selectedPot)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Image(selectedSoil)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                    Image(selectedPlant)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .padding(.top, 20)
                
               
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(Color.green.opacity(0.3))
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .center)
                
                
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(minimum: 100), spacing: 15),
                            GridItem(.flexible(minimum: 100), spacing: 15),
                            GridItem(.flexible(minimum: 100), spacing: 15)
                        ],
                        spacing: 20
                    ) {
                        ForEach(currentOptions().indices, id: \.self) { index in
                            let imageName = currentOptions()[index]
                            let price = currentPrices()[index]
                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .border(Color.green, width: 3)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedItem = imageName
                                        selectedItemPrice = price
                                        isBuySheetPresented = true
                                    }
                                Text("\(price)⭐")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                
                Spacer()
            }
            .navigationTitle("Customise Your Tree")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isBuySheetPresented) {
                // Buy Page Modal
                if let selectedItem = selectedItem {
                    VStack(spacing: 20) {
                        Text("Buy \(selectedItem)?")
                            .font(.headline)
                            .padding()
                        
                        Image(selectedItem)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        
                        Text("Price: \(selectedItemPrice)⭐")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 20) {
                            Button("Cancel") {
                                isBuySheetPresented = false
                            }
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            
                            Button("Buy") {
                                if stars >= selectedItemPrice {
                                    stars -= selectedItemPrice
                                    updateSelectedImage(for: selectedItem)
                                    isBuySheetPresented = false
                                }
                            }
                            .padding()
                            .background(stars >= selectedItemPrice ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .disabled(stars < selectedItemPrice)
                        }
                    }
                    .padding()
                    .presentationDetents([.fraction(0.4)])
                }
            }
        }
    }
    
   
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
    
    
    func currentPrices() -> [Int] {
        switch selectedCategory {
        case "Pot":
            return potPrices
        case "Soil":
            return soilPrices
        case "Plant":
            return plantPrices
        default:
            return []
        }
    }
    

    func updateSelectedImage(for imageName: String) {
        switch selectedCategory {
        case "Pot":
            selectedPot = imageName
        case "Soil":
            selectedSoil = imageName
        case "Plant":
            selectedPlant = imageName
        default:
            break
        }
    }
}
#Preview {
    CustomisationView(stars: .constant(25))
}
