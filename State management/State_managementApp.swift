//
//  State_managementApp.swift
//  State management
//
//  Created by Rose Visuals on 02/03/2026.
//

import SwiftUI

@main
struct State_managementApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(cart: CartViewModel())
        }
    }
}
