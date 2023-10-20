//
//  MainTabView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 20/09/23.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
            TabView {
                MainView()
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Navegar")
                    }
                
                ConteudosView()
                    .tabItem {
                        Image(systemName: "play.rectangle")
                        Text("Conteúdos")
                    }
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Perfil")
                    }
                
                
            }//: TABVIEW
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
