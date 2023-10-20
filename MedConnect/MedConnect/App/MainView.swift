//
//  MainView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 20/09/23.
//

import SwiftUI

struct MainView: View {
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var isModalViewPresented = false
    @State private var selectedSegment = 0
    @State private var isShowingElements = true
    let segments = ["Notícias", "Resumos", "Dicas"]
    
    var body: some View {
        NavigationView {
            VStack {
                if isShowingElements {
                    Picker("", selection: $selectedSegment) {
                        ForEach(0 ..< segments.count, id: \.self) { index in
                            Text(segments[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                if selectedSegment == 0 {
                    NoticiasView(isShowingElements: $isShowingElements)
                } else if selectedSegment == 1 {
                    NoticiasView(isShowingElements: $isShowingElements)
                } else if selectedSegment == 2 {
                    NoticiasView(isShowingElements: $isShowingElements)
                }
                
                Spacer()
            }//: VSTACK
            .navigationBarItems(leading:
                                    
                                    HStack {
                if isShowingElements {
                    Button(action: {
                        withAnimation {
                            isSearching.toggle()
                            if !isSearching {
                                searchText = ""
                            }
                        }
                    }, label: {
                        Image(systemName: isSearching ? "xmark.circle.fill" : "magnifyingglass")
                    })
                }
                
                if isSearching {
                    TextField("Pesquisar", text: $searchText)
                }
                
            }
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isShowingElements {
                        Button {
                            isModalViewPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isModalViewPresented) {
                AddNoticiaView(isModalViewPresented: $isModalViewPresented)
            }
        }//: NAVVIEW
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
