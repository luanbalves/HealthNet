//
//  ListaItensView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 18/10/23.
//

import SwiftUI
import Kingfisher

struct ListaItensView: View {
    let news: Noticia
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            KFImage(URL(string: news.selectedImage))
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack {
                Text(news.newsTitle)
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
    
    @State static var news = Noticia(id: "1", newsTitle: "Titulo", newsText: "Texto", selectedImage: "img")
    
    static var previews: some View {
        ListaItensView(news: news)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
