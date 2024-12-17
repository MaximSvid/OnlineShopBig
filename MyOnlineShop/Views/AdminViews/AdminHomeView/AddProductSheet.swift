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
    @State private var toast: Toast? = nil
    
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Add Product")
                    .font(.title)
                    .padding([.top, .bottom])
                
                HStack {
                    Text("Product Name")
                        .font(.body)
                    Spacer()
                }
                
                TextField("Product Name", text: $productViewModel.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                HStack {
                    VStack (alignment: .leading) {
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
                    
                    VStack (alignment: .leading) {
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
                .padding(.bottom
                )
                HStack {
                    Text ("Brand")
                        .font(.body)
                    Spacer()
                }
                
                TextField("Brand", text: $productViewModel.brand)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                HStack {
                    Text("Description")
                        .font(.body)
                    Spacer()
                }
                
                TextEditor (text: $productViewModel.description)
                    .frame(height: 100)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray.opacity(0.4), lineWidth: 0.5)
                    )
                    .padding(.bottom)
                
                HStack {
                    Text("Category")
                        .font(.body)
                    Spacer()
                }
                
                Picker("Category", selection: $productViewModel.category) {
                    ForEach(Categories.allCases.filter {$0 != .allProducts && $0 != .action }, id: \.self) {category in
                        Text(category.rawValue)
                            .tag(category)
                    }
                }
                .pickerStyle(.wheel)
                .padding(.bottom)
                
                
                
                
                HStack {
                    VStack {
                        
                        HStack {
                            Text("Rating")
                                .font(.body)
                            Spacer()
                        }
                        
                        TextField("Rating", text: $ratingString)
                            .onChange(of: ratingString) {
                                productViewModel.rating = Double(Int(ratingString) ?? 0)
                            }
                            .onAppear {
                                ratingString = String(productViewModel.rating)
                            }
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Spacer()
                    VStack {
                        Toggle("Visibility", isOn: $productViewModel.isVisible)
                    }
                }
                
                Toggle("Action", isOn: $productViewModel.action)
                
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(ColorEnum.allCases, id: \.self) { color in
                                Circle()
                                    .fill(color.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(productViewModel.selectedColor == color ? Color.black : Color.clear, lineWidth: 0.3)
                                    )
                                    .onTapGesture {
                                        productViewModel.selectedColor = color                                    }
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .padding([.top, .bottom])
                
                Button(action: {
                    
                    guard !productViewModel.title.isEmpty,
                          !productViewModel.description.isEmpty,
                          !productViewModel.description.isEmpty
                    else {
                        toast = Toast(style: .error, message: "Please fill all fields")
                        return
                    }
                    productViewModel.addNewProduct()
                    productViewModel.isAddSheetOpen.toggle()
                    
                    productViewModel.title = ""
                    productViewModel.price = 0.0
                    productViewModel.description = ""
                    productViewModel.brand = ""
                    productViewModel.countProduct = 0
                    productViewModel.rating = 0.0
                    productViewModel.isVisible = true
                    productViewModel.action = false
                    priceString = ""
                    countString = ""
                    ratingString = ""
                }) {
                    Text ("Add+")
                        .font(.headline.bold())
                        .frame(width: .infinity, height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue.opacity(0.8))
                        .clipShape(.buttonBorder)
                }
                .shadow(radius: 3)
            }
            .padding([.trailing, .leading])
            .toastView(toast: $toast)
        }
        
    }
}

#Preview {
    AddProductSheet()
        .environmentObject(ProductViewModel())
}

