//
//  ListaItensView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 18/10/23.
//

import SwiftUI

struct ListaItensView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image("img")
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack {
                Text("Título")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
                
                Text("Subtexto contendo um breve resumo do que está sendo tratado.")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)

            }//: VSTACK
        }//: HSTACK
    }
}

struct ListaItensView_Previews: PreviewProvider {
    static var previews: some View {
        ListaItensView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
