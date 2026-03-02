//
//  ContentView.swift
//  State management
//
//  Created by Rose Visuals on 02/03/2026.
//

import SwiftUI
import Combine
/// the @Published lives in the combine , if not imported i get an error

class CartViewModel: ObservableObject {
    /// when declaring a class for view model that is going to conform to changes , we declare it using the @ObservableObject not the @ObservedObject
    @Published var itemCount = 0
    //Itemcount is not the correct way to declare variables in SwiftUI we use the lowerCamell case format
}
struct HomeView: View {
    @StateObject var cart = CartViewModel()
    ///@StateOBject owns and creates the instance because it has the = CartViewModel()
    
    var body: some View {
        VStack{
            Text ("Items \(cart.itemCount)")
                
            Button ("Add item"){
                cart.itemCount += 1
            }
            .frame(width: 100, height:50)
            .background(Color.black.opacity(1))
            .cornerRadius(10)
        }
    }
}
struct ContentView: View {
    
    @ObservedObject var cart: CartViewModel
    ///@ObservedObject expects arguments which conform to the @ObservableOBject
    /// because @ObservedObject is a property passsed into the view from a parent. #it expects you to supply an object
    var body: some View {
        VStack(){
            
            HomeView(cart: cart)
            Text ("Cart has \(cart.itemCount) items")
        }
        
    }
}

#Preview {
    ContentView(cart: CartViewModel())
}
