//
//  AddProductSheet.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 16.12.24.
//

//import AlertToast
import SwiftUI
//import AlertToast
//import Toast


struct AddProductSheet: View {
//    @ObservedObject var productViewModel: ProductViewModel
    @EnvironmentObject var productViewModel: ProductViewModel
    @State private var priceString: String = ""
    @State private var countString: String = ""
    @State private var ratingString: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Add Product")
                    .font(.title)
                Text("Product Name")
                    .font(.body)
                TextField("Product Name", text: $productViewModel.title)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    VStack {
                        Text("Price")
                            .font(.body)
                        TextField("Price", text: $priceString)
                            .keyboardType(.decimalPad)
                            .onChange(of: priceString) {
                                productViewModel.price = Double(priceString) ?? 0.0
                            }
                            .onAppear {
                                priceString = String(format: "%.2f", productViewModel.price)
                            }
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Count Products")
                            .font(.body)
                        
                        TextField("Count Products", text: $countString)
                            .onChange(of: countString) {
                                productViewModel.countProduct = Int(countString) ?? 0
                            }
                            .onAppear {
                                countString = String(productViewModel.countProduct)
                            }
                            .textFieldStyle(.roundedBorder)
                    }
                    
                }
                Text ("Brand")
                    .font(.body)
                TextField("Brand", text: $productViewModel.brand)
                    .textFieldStyle(.roundedBorder)
                
                Text("Description")
                    .font(.body)
                TextField("Description", text: $productViewModel.description)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3)
                
                Text("Category")
                    .font(.body)
                TextField("Category", text: $productViewModel.category)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    VStack {
                        Text("Rating")
                            .font(.body)
                        TextField("Rating", text: $ratingString)
                            .onChange(of: ratingString) {
                                productViewModel.rating = Double(Int(ratingString) ?? 0)
                            }
                            .onAppear {
                                ratingString = String(productViewModel.rating)
                            }
                            .keyboardType(.numberPad)
                    }
                    
                    Spacer()
                    VStack {
                        Text("Visibility")
                            .font(.body)
                        Toggle("Visibility", isOn: $productViewModel.isVisible)
                    }
                }
                
                HStack {
                    Text("Color")
                        .font(.body)
                    Picker("Select Color", selection: $productViewModel.selectedColor) {
                        ForEach (ColorEnum.allCases) { color in
                            HStack {
                                Circle()
                                    .fill(color.color)
                                    .frame(width: 20, height: 20)
                                Text(color.rawValue)
                            }
                            .tag(color)
                        }
                    }
                    .pickerStyle(.inline)
                }
                
                Button(action: {
                    
                    guard !productViewModel.title.isEmpty,
                          !productViewModel.description.isEmpty,
                          !productViewModel.description.isEmpty,
                          !productViewModel.category.isEmpty else {
                        print("Enter all fields")
                        return
                    }
                    
                    productViewModel.addSheet.toggle()
                }) {
                    Text ("Add+")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .clipShape(.buttonBorder)
                .shadow(radius: 3)
            }
            .padding([.trailing, .leading])
        }
       
    }
}

#Preview {
    AddProductSheet()
        .environmentObject(ProductViewModel())
}
