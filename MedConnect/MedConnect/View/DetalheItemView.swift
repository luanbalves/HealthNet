//
//  DetalheItemView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 18/10/23.
//

import SwiftUI
import Kingfisher

struct DetalheItemView: View {
    
    @Binding var isShowingElements : Bool
    let news: Noticia
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                // TITULO
                
                Text(news.newsTitle.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    .background(
                        Color.accentColor
                            .frame(height: 6)
                            .offset(y: 24)
                    )
                
                // SUBTEXTO
                
                Text(news.subtitle)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 30)
                
                // IMAGEM PRINCIPAL
                
                KFImage(URL(string: news.selectedImage))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 225)
                    .cornerRadius(12)
                
                Text(news.imageSubtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // TEXTO PRINCIPAL
                
                Group {
                    HeadingView(headingImage: "text.viewfinder", headingText: "Texto")
                    Text(news.newsText)
                        .layoutPriority(1)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .lineSpacing(6)
                }
                .padding(.horizontal)
                
                // GALERIA DE FOTOS
                
                Group {
                    HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Galeria")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 15) {
                            ForEach(0..<5, id: \.self) { _ in
                                Image("img")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(12)
                            }//: LOOP
                        }//: HSTACK
                    }//: SCROLL
                    
                }
                .padding(.horizontal)
                
                // PERFIL QUE FEZ A POSTAGEM
                
                Group {
                    HeadingView(headingImage: "person.text.rectangle", headingText: "Perfil")
                    
                    HStack {
                        Circle()
                            .frame(width: 48, height: 48)
                        VStack(alignment: .leading) {
                            Text("Luan Alves")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Text("Médico")
                                .font(.footnote)
                            
                            Text("CRM: 123456")
                                .font(.footnote)
                        }//: VSTACK
                    }//: HSTACK
                }//: GROUP
                .padding(.horizontal)
                
            }//: VSTACK
            .navigationBarTitle("Aprenda sobre \(news.newsTitle)", displayMode: .inline)
            .onAppear {
                isShowingElements = false
            }
            
            .onDisappear  {
                withAnimation {
                    isShowingElements = true
                }
            }

        }//: SCROLLVIEW
    }
}

struct DetalheItemView_Previews: PreviewProvider {
    
    @State static var isShowingElements = true
    @State static var news = Noticia(id: "1", newsTitle: "Titulo", newsText: "Texto", selectedImage: "img", subtitle: "Subtitulo", imageSubtitle: "Subtitulo da imagem")
    
    static var previews: some View {
        DetalheItemView(isShowingElements: $isShowingElements, news: news)
    }
}
