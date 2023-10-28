//
//  AddNoticiaView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 18/10/23.
//

import SwiftUI
import PhotosUI

struct AddNoticiaView: View {
    
    @State private var newsTitle = ""
    @State private var newsText = ""
//    @State private var hasPhotoGallery = false
//    @State private var selectedPhotos: [Image?] = [nil, nil, nil, nil, nil]
    @Binding var isModalViewPresented: Bool
    @StateObject var viewModel = NoticiasViewModel()
    @State private var imagePickerPresented = false
    @State private var imageSubtitle = ""
    @State private var subtitle = ""
    @State private var isUploading = false
    
    var body: some View {
        NavigationView {
                    Form {
                        Section(header: Text("Título")) {
                            TextField("Digite o título da notícia", text: $newsTitle)
                        }

                        Section(header: Text("Subtítulo")) {
                            TextField("Digite o subtítulo da notícia", text: $subtitle)
                        }
                        
                        Section(header: Text("Texto")) {
                            TextEditor(text: $newsText)
                        }
                        
                        Section(header: Text("Imagem")) {
                            
                                Button(action: {
                                    imagePickerPresented.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "photo.on.rectangle")
                                        Text("Selecionar Imagem")
                                    }
                                }
                                .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)

                            if viewModel.postImage != nil {
                                viewModel.postImage?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(12)
                            }
                        }
                        
                        Section(header: Text("Legenda da imagem")) {
                            TextField("Digite a legenda da imagem", text: $imageSubtitle)
                        }
                        
//                        Section(header: Text("Galeria de Fotos")) {
//                            Toggle("Adicionar galeria de fotos", isOn: $hasPhotoGallery)
//
//                            if hasPhotoGallery {
//                                ForEach(0..<selectedPhotos.count, id: \.self) { index in
//                                    if let photo = selectedPhotos[index] {
//                                        photo
//                                            .resizable()
//                                            .scaledToFit()
//                                            .frame(height: 200)
//                                            .cornerRadius(12)
//                                    } else {
//                                        Button(action: {
//                                            selectedPhotos[index] = Image("img")
//                                        }) {
//                                            Text("Selecionar Foto \(index + 1)")
//                                        }
//                                    }
//                                }
//
//                                if selectedPhotos.count < 5 {
//                                    Button(action: {
//                                        selectedPhotos.append(nil)
//                                    }) {
//                                        Text("Adicionar Foto")
//                                    }
//                                }
//                            }
//                        }

                        Section {
                            Button("Salvar Notícia") {
                                isUploading = true
                                
                                Task {
                                    try await viewModel.uploadNews(newsTitle: newsTitle, newsText: newsText, subtitle: subtitle, imageSubtitle: imageSubtitle)
                                    isModalViewPresented = false
                                    isUploading = false
                                }
                            }
                            .fontWeight(.bold)
                            .disabled(newsTitle.isEmpty || viewModel.selectedImage == nil || isUploading || newsText.isEmpty || subtitle.isEmpty || imageSubtitle.isEmpty)
                        }
                    }//: FORM
                    .navigationTitle("Adicionar Notícia")
                    .navigationBarItems(trailing:
                        Button("Cancelar") {
                            isModalViewPresented = false
                        }
                    )

        }//: NAVVIEW
    }
}

struct AddNoticiaView_Previews: PreviewProvider {
    
    @State static var isModalViewPresented = true
    
    static var previews: some View {
        AddNoticiaView(isModalViewPresented: $isModalViewPresented)
    }
}
