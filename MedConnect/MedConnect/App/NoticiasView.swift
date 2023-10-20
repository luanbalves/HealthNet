//
//  NoticiasView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 18/10/23.
//

import SwiftUI

struct NoticiasView: View {
    
    @Binding var isShowingElements: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<5, id: \.self) { _ in
                    NavigationLink(destination: DetalheItemView(isShowingElements: $isShowingElements)) {
                        ListaItensView()
                    }
                }
            }//: LIST
            .navigationTitle("Notícias")
        }//: NAVVIEW
    }
}

struct NoticiasView_Previews: PreviewProvider {
    
    @State static var isShowingElements = true
    
    static var previews: some View {
        NoticiasView(isShowingElements: $isShowingElements)
    }
}
