//
//  SelectedContentView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 03/11/23.
//

import SwiftUI

struct SelectedContentView: View {
    
    @State private var isSearching = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                HStack {
                    TextField("Pesquisar", text: $searchText)
                        .padding(.leading, 24)
                    
                    if isSearching {
                        Button {
                            searchText = ""
                            isSearching = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }//: BUTTON
                        .padding(.trailing, 8)
                    } else {
                        Button {
                            isSearching = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }//: BUTTON
                        .padding(.trailing, 8)
                    }
                    
                }//: HSTACK
                .padding()
                .background(Color.primary.opacity(0.1))
                .cornerRadius(112)
                .frame(width: UIScreen.main.bounds.width - 28)
                .padding(.bottom, 25)
                
                ForEach(0..<5, id: \.self) { _ in
                    HStack {
                        Image("img")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 130)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                            .padding(.horizontal)
                            .padding(.vertical)
                        
                        Text("Título apenas para teste")
                            .fontWeight(.heavy)
                            .foregroundColor(.accentColor)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                        
                            Spacer()
                    }//: HSTACK
                }//: LOOP
                .background(Color.secondary.opacity(0.12))
                .cornerRadius(15)
                .shadow(radius: 20)
                .padding(.vertical, 7)
                
            }//: SCROLLVIEW
            .navigationTitle("Vídeos")
            .navigationBarTitleDisplayMode(.inline)
        }//: NAVSTACK
    }
}

struct SelectedContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedContentView()
    }
}
