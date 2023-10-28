//
//  NoticiasView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 18/10/23.
//

import SwiftUI

struct NoticiasView: View {
    
    @Binding var isShowingElements: Bool
    @StateObject var viewModel = NoticiasViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.news) { news in
                    NavigationLink(destination: DetalheItemView(isShowingElements: $isShowingElements, news: news)) {
                        ListaItensView(news: news)
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
