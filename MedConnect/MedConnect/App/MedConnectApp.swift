//
//  MedConnectApp.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 09/09/23.
//

import SwiftUI
import Firebase
@main
struct MedConnectApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
