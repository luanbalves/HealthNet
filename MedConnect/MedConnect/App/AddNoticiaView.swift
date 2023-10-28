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
    @State private var hasImage = false
    @State private var selectedImage: Image?
    @State private var hasPhotoGallery = false
    @State private var selectedPhotos: [Image?] = [nil, nil, nil, nil, nil]
    @Binding var isModalViewPresented: Bool
    @StateObject var viewModel = NoticiasViewModel()
    @State private var imagePickerPresented = false
    
    var body: some View {
        NavigationView {
                    Form {
                        Section(header: Text("Título")) {
                            TextField("Digite o título da notícia", text: $newsTitle)
                        }

                        Section(header: Text("Texto")) {
                            TextEditor(text: $newsText)
                        }

                        Section(header: Text("Imagem")) {
                            Toggle("Adicionar imagem", isOn: $hasImage)
                            
                            if hasImage {
                                Button(action: {
                                    imagePickerPresented.toggle()
                                }) {
                                    Text("Selecionar Imagem")
                                }
                                .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
                            }
                            
                            if viewModel.postImage != nil && hasImage == true {
                                viewModel.postImage?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 200)
                                    .cornerRadius(12)
                            }
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
                                Task {
                                    try await viewModel.uploadNews(newsTitle: newsTitle, newsText: newsText)
                                    isModalViewPresented = false
                                }
                            }
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
