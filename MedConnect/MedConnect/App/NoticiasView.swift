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
    @State private var isSearching = false
    @State private var isModalViewPresented = false
    
    var body: some View {
        NavigationView {
            
            List {
                HStack {
                    Button(action: {
                        withAnimation {
                            isSearching.toggle()
                            if !isSearching {
                                viewModel.searchText = ""
                            }
                        }
                    }, label: {
                        Image(systemName: isSearching ? "xmark.circle.fill" : "magnifyingglass")
                    })
                    .foregroundColor(.accentColor)
                    .buttonStyle(PlainButtonStyle())
                    
                    if isSearching {
                        TextField("Pesquisar", text: $viewModel.searchText)
                            .frame(maxWidth: .infinity)
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        isModalViewPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(.accentColor)
                    .buttonStyle(PlainButtonStyle())

                }//: HSTACK
                
                ForEach(viewModel.filteredNews) { news in
                    NavigationLink(destination: DetalheItemView(isShowingElements: $isShowingElements, news: news)) {
                        ListaItensView(news: news)
                    }
                }
                
                
            }//: LIST
            .navigationTitle("Notícias")
            .refreshable {
                Task { try await viewModel.fetchNews() }
            }
            .sheet(isPresented: $isModalViewPresented) {
                AddNoticiaView(isModalViewPresented: $isModalViewPresented)
            }
        }//: NAVVIEW
    }
}

struct NoticiasView_Previews: PreviewProvider {
    
    @State static var isShowingElements = true
    
    static var previews: some View {
        NoticiasView(isShowingElements: $isShowingElements)
    }
}
