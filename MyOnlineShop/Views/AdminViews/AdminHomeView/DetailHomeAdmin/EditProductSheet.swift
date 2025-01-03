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
    @State private var selectedColor: ColorEnum = .red
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
//                                    .overlay(
//                                        Circle()
//                                            .stroke(product.selectedColor == color ? Color.black : Color.clear, lineWidth: 2)
//                                    )
//                                    .onTapGesture {
//                                        product.selectedColor = color
//                                    }
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                    }
                }
                .padding([.top, .bottom])
                
                Button(action: {
                    // Формирование обновленного продукта
//                    let  updatedImages = self.updatedImages.isEmpty ? product.images : self.updatedImages
                    
                    let updatedProduct = Product(
                        id: product.id,
                        title: title,
                        price: Double(priceString) ?? 0.0,
                        actionPrice: Double(actionPriceString) ?? 0.0,
                        description: description,
                        brand: brand,
                        countProduct: Int(countString) ?? 0,
                        category: category.rawValue,
                        images: product.images, // оставляем текущий image
                        rating: Double(ratingString) ?? 0.0,
                        isVisible: isVisible,
                        selectedColor: selectedColor.rawValue,
                        isFavorite: product.isFavorite,
                        action: action,
                        dateCreated: product.dateCreated
                    )
                    
                    // Обновление товара
                    productViewModel.updateProduct(product: updatedProduct)
                    productViewModel.isEditSheetOpen = false
                    
                }) {
                    Text ("Edit")
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
            .onAppear {
                title = product.title
                priceString = String(format: "%.2f", product.price)
                actionPriceString = String(format: "%.2f", product.actionPrice)
                countString = String(product.countProduct)
                description = product.description
                brand = product.brand
                category = Categories(rawValue: product.category) ?? .livingRoom
                selectedColor = ColorEnum(rawValue: product.selectedColor) ?? .blue
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

