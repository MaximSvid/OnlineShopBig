//
//  DetailHomeAdmin.swift
//  MyOnlineShop
//
//  Created by Maxim Svidrak on 17.12.24.
//

import SwiftUI

struct DetailHomeAdmin: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    //    @Binding var selectedColor: ColorEnum
    var product: Product
    
    var body: some View {
        
        NavigationStack {
            VStack (alignment: .leading) {
                
                Image("image")
                    .resizable()
                    .frame(width: .infinity, height: 250)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text (product.title)
                            .font(.headline.bold())
                        
                    }
                    
                    
                    Spacer()
                    
                    HStack {
                        if product.action && product.actionPrice > 0.0 {
                            // main price mit linie
                            Text(String(format: "€%.2f", product.price))
                                .font(.headline)
                                .foregroundStyle(product.isVisible ? .gray : .gray.opacity(0.5))
                                .strikethrough(true, color: .gray) // linie
                            
                            // ActionPrice
                            Text(String(format: "€%.2f", product.actionPrice))
                                .font(.caption)
                                .foregroundStyle(.red)
                        } else {
                            // Nur main price
                            Text(String(format: "€%.2f", product.price))
                                .font(.headline)
                                .foregroundStyle(product.isVisible ? .black : .gray)
                        }
                        
                    }
                }
                .padding([.top, .bottom])
                
                HStack {
                    Text(product.brand)
                        .font(.callout)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.callout)
                            .foregroundStyle(.yellow)
                        
                        Text(String(format: "%.1f", product.rating))                            .font(.callout)
                    }
                }
                
                HStack {
                    Text("Quantity of goods:")
                        .font(.callout)
                    
                    Spacer()
                    if product.countProduct > 0 {
                        Text("\(product.countProduct)")
                            .font(.callout)
                            .foregroundStyle(product.countProduct <= 10 ? .red : .primary)
                    } else {
                        Text("Out of stock")
                            .font(.callout)
                            .foregroundStyle(.red)
                            .onAppear {
                                productViewModel.toggleVisibility(for: product)
                            }
                    }
                }
                .padding(.top, 3)
                .padding(.bottom, 3)
                
                HStack {
                    Text("Select a  Color")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(ColorEnum.allCases, id: \.self) { color in
                                Circle()
                                    .fill(color.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(productViewModel.selectedColor == color ? Color.gray : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        productViewModel.selectedColor = color
                                    }
                            }
                        }
                        .padding(.horizontal, 8)
                        .padding(.top, 3)
                        .padding(.bottom, 3)
                    }
                }
                .padding([.top, .bottom])
                
                Text(product.description)
                    .font(.footnote)
                    .padding([.top, .bottom])
                
                Spacer()
            }
        }
        .sheet(isPresented: $productViewModel.isEditSheetOpen) {
            EditProductSheet(product: product)
                .presentationDragIndicator(.visible)
            
        }
        .padding([.leading, .trailing])
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("HomeDetail Admin")
                    .font(.title)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    productViewModel.isEditSheetOpen = true
                }) {
                    Image(systemName: "pencil.circle")
                        .font(.headline)
                        .foregroundStyle(.gray)
                        .padding(8)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
            }
        }
    }
}


#Preview {
    //    DetailHomeAdmin()
}
