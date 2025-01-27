//
//  EditProductSheet.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 20.12.24.
//

import SwiftUI

struct EditProductSheet: View {
    
    var product: Product
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var imgurViewModel: ImgurViewModel
    
    @State private var title: String = ""
    @State private var priceString: String = ""
    @State private var actionPriceString: String = ""
    @State private var countString: String = ""
    @State private var ratingString: String = ""
    @State private var description: String = ""
    
    @State private var brand: String = ""
    @State private var action: Bool = false
    
    
    @State private var category: Categories = .livingRoom
    //    @State private var selectedColor: ColorEnum = .red
    @State private var selectedColor: ColorEnum = .caramelBrown
    @State private var isVisible: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Edit Product")
                    .font(.title)
                    .padding([.top, .bottom])
                
                ImageUploadView()
                
                Divider()
                
                
                HStack {
                    Text("Product Name")
                        .font(.body)
                    Spacer()
                }
                
                TextField("Product Name", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                HStack {
                    VStack (alignment: .leading) {
                        Text("Price")
                            .font(.body)
                        TextField("Price", text: $priceString)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        Text("Action Price")
                            .font(.body)
                        TextField("Action Price", text: $actionPriceString)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    
                    
                }
                .padding(.bottom)
                
                VStack (alignment: .leading) {
                    Text("Count Products")
                        .font(.body)
                    
                    TextField("Count Products", text: $countString)
                    
                        .textFieldStyle(.roundedBorder)
                }
                
                HStack {
                    Text ("Brand")
                        .font(.body)
                    Spacer()
                }
                
                TextField("Brand", text: $brand)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                HStack {
                    Text("Description")
                        .font(.body)
                    Spacer()
                }
                
                TextEditor (text: $description)
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
                
                Picker("Category", selection: $category) {
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
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Spacer()
                    VStack {
                        Toggle("Visibility", isOn: $isVisible)
                    }
                }
                
                Toggle("Action", isOn: $action)
                
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
                                        productViewModel.selectedColor = color
                                    }
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                }
                .padding([.top, .bottom])
                Button(action: {
                    
                    productViewModel.title = title
                    productViewModel.price = Double(priceString) ?? 0.0
                    productViewModel.actionPrice = Double(actionPriceString) ?? 0.0
                    productViewModel.description = description
                    productViewModel.brand = brand
                    productViewModel.countProduct = Int(countString) ?? 0
                    productViewModel.category = category
                    productViewModel.rating = Double(ratingString) ?? 0.0
                    productViewModel.isVisible = isVisible
                    productViewModel.selectedColor = selectedColor
                    productViewModel.action = action
                    
                    productViewModel.updateProduct()
                    productViewModel.isEditSheetOpen = false
                    
                }) {
                    Text ("Edit")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color.primaryBrown)
                        .clipShape(RoundedRectangle(cornerRadius: 3))
                }
                .shadow(radius: 3)
            }
            .padding([.trailing, .leading])
            .onAppear {
                productViewModel.setSelectedProduct(product)
                title = product.title
                priceString = String(format: "%.2f", product.price)
                actionPriceString = String(format: "%.2f", product.actionPrice)
                countString = String(product.countProduct)
                description = product.description
                brand = product.brand
                category = Categories(rawValue: product.category) ?? .livingRoom
                selectedColor = ColorEnum(rawValue: product.selectedColor) ?? .caramelBrown
                isVisible = product.isVisible
                action = product.action
            }
            
        }
    }
}

//#Preview {
//    EditProductSheet()
//        .environmentObject(ProductViewModel())
//}

