//
//  DetalheItemView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 18/10/23.
//

import SwiftUI

struct DetalheItemView: View {
    
    @Binding var isShowingElements : Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                // TITULO
                
                Text("Título".uppercased())
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
                
                Text("Subtexto contendo um breve resumo do que está sendo tratado.")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal, 30)
                
                // IMAGEM PRINCIPAL
                
                Image("img")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 225)
                    .cornerRadius(12)
                
                Text("Legenda da foto")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // TEXTO PRINCIPAL
                
                Group {
                    HeadingView(headingImage: "text.viewfinder", headingText: "Texto")
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi luctus maximus rhoncus. Praesent porttitor, purus ac congue convallis, lorem ante interdum lorem, at egestas elit augue ut risus. Sed sed odio sed risus rhoncus hendrerit. Curabitur sit amet accumsan mauris, eget tincidunt purus. Mauris venenatis massa nisi, imperdiet egestas mauris venenatis a. Sed lobortis tincidunt augue ut consectetur. Praesent est leo, laoreet ac urna eu, sodales hendrerit nisl. Maecenas quis dictum libero. Cras at urna felis. Vivamus urna odio, laoreet at ultricies ornare, interdum ut neque. Cras in urna quis libero auctor vehicula et eu felis. Etiam malesuada mauris rhoncus feugiat facilisis. \n\nAliquam erat volutpat. Nulla risus ante, placerat sed massa sit amet, luctus tincidunt diam. Maecenas in tincidunt ipsum. Cras ullamcorper tempus imperdiet.")
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
            .navigationBarTitle("Aprenda sobre Titulo", displayMode: .inline)
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
    
    static var previews: some View {
        DetalheItemView(isShowingElements: $isShowingElements)
    }
}
