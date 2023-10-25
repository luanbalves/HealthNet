//
//  AddConteudoView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 24/10/23.
//

import SwiftUI
import PhotosUI

struct AddConteudoView: View {
    
    @StateObject var viewModel = ConteudosViewModel()
    @Binding var isModalViewPresented: Bool
    @State private var title = ""
    @State private var videoSelected = false
    @State private var isUploading = false
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("titulo")) {
                    TextField("Digite o título do vídeo", text: $title)
                }
                
                Section(header: Text("video")) {
                    PhotosPicker(selection: $viewModel.selectedItem, matching: .any(of: [.videos, .not(.images)])) {
                        Label("Selecionar vídeo", systemImage: "photo.on.rectangle")
                    }.onChange(of: viewModel.selectedItem) { _ in
                        videoSelected = true
                    }
                }
                
                Section(header: Text("Vídeo Selecionado")) {
                    if videoSelected {
                        HStack {
                            Image(systemName: "checkmark.seal.fill")
                            Text("Vídeo Selecionado")
                        }
                    } else {
                        Text("Aguardando seleção do vídeo...")
                    }
                }
                
                Section {
                    Button("Fazer publicação") {
                        isUploading = true
                        viewModel.videoTitle = title
                        
                        Task {
                            do {
                                try await viewModel.uploadVideo()
                                isUploading = false
                                isModalViewPresented = false
                            }catch {
                                print("\(error)")
                            }
                        }
                    }
                    .disabled(title.isEmpty || viewModel.selectedItem == nil || isUploading)
                }
                
            }//: FORM
            .navigationTitle("Adicionar conteúdo")
            .navigationBarItems(trailing:
                                    Button("Cancelar") {
                isModalViewPresented = false
            }
            )
        }//: NAVVIEW
    }
}

struct AddConteudoView_Previews: PreviewProvider {
    
    @State static var isModalViewPresented = true
    
    static var previews: some View {
        AddConteudoView(isModalViewPresented: $isModalViewPresented)
    }
}
