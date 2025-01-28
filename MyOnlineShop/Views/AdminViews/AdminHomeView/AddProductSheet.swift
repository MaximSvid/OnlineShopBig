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
    @EnvironmentObject var productViewModel: ProductViewModel
    @EnvironmentObject var imgurViewModel: ImgurViewModel
    @State private var errorMessage: Bool = false
    
    var body: some View {
        ScrollView {
            Text("Add Product")
                .font(.title)
                .padding([.top, .bottom])
            
            ImageUploadView()
            
            Divider()
            
            CustomTitleRow(title: "Product Name")
            CustomTextField(placeholder: "Product Name", text: $productViewModel.title)
            
            CustomTitleRow(title: "Price")
            CustomNumberDoubleField(placeholder: "Price", value: $productViewModel.price)
            
            CustomTitleRow(title: "Action Price")
            CustomNumberDoubleField(placeholder: "Action Price", value: $productViewModel.actionPrice)
            
            CustomTitleRow(title: "Count Products")
            CostomNumberIntField(placeholder: "Count Products", value: $productViewModel.countProduct)
            
            CustomTitleRow(title: "Brand")
            CustomTextField(placeholder: "Brand", text: $productViewModel.brand)
            
            CustomTitleRow(title: "Description")
            TextEditor (text: $productViewModel.description)
                .frame(height: 100)
                .padding(.vertical, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.4), lineWidth: 0.5)
                )
                .padding(.bottom)
            
            CustomTitleRow(title: "Category")
            Picker("Category", selection: $productViewModel.category) {
                ForEach(Categories.allCases.filter {$0 != .allProducts && $0 != .action }, id: \.self) {category in
                    Text(category.rawValue)
                        .tag(category)
                }
            }
            .pickerStyle(.wheel)
            .padding(.bottom)
            
            CustomTitleRow(title: "Rating")
            CustomNumberDoubleField(placeholder: "Rating", value: $productViewModel.rating)
            
            VStack {
                Toggle("Visibility", isOn: $productViewModel.isVisible)
            }
            .padding(.bottom)
            .padding(.trailing)
            
            Toggle("Action", isOn: $productViewModel.action)
                .padding(.trailing)
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(ColorEnum.allCases, id: \.self) { color in
                            Circle()
                                .fill(color.color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(productViewModel.selectedColor == color ? Color.black : Color.clear, lineWidth: 1)
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
            
            if errorMessage {
                Text("Please fill all fields")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            CustomMainButton(action: {
                if productViewModel.title.isEmpty {
                    errorMessage = true
                } else {
                    productViewModel.addNewProduct()
                    productViewModel.isAddSheetOpen.toggle()
                }
            }, title: "Add+")
        }
        .scrollIndicators(.hidden)
        .padding([.trailing, .leading])
    }
}


#Preview {
    AddProductSheet()
        .environmentObject(ProductViewModel())
        .environmentObject(ImgurViewModel())
}

