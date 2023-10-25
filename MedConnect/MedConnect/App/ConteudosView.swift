//
//  ConteudosView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 20/09/23.
//

import SwiftUI
import PhotosUI
import AVKit

struct ConteudosView: View {
    @StateObject var viewModel = ConteudosViewModel()
    @State private var isSearching = false
    @State private var isModalViewPresented = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    TextField("Pesquisar", text: $viewModel.searchText)
                        .padding(.leading, 24)
                    
                    if isSearching {
                        Button {
                            viewModel.searchText = ""
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
                
                ScrollView {
                    ForEach(viewModel.filteredVideos) { video in
                        VideoThumbnailView(video: video)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                    }
                    
                }//: SCROLLVIEW
                .refreshable {
                    Task { try await viewModel.fetchVideos() }
                }
                .navigationTitle("Conteudos")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isModalViewPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isModalViewPresented) {
                    AddConteudoView(isModalViewPresented: $isModalViewPresented)
                }
                
            }//: SCROLLVIEW
        }//: NAVSTACK
    }
}

struct VideoThumbnailView: View {
    let video: Video
    @Environment(\.colorScheme) var colorScheme
    @State private var isLiked = false
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.primary)
                
                Text("Nome")
                    .font(.headline)
                
                Spacer()
            }//: HSTACK
            
            VideoPlayer(player: AVPlayer(url: URL(string: video.videoUrl)!))
                .frame(height: 200)
            
            HStack {
                Text(video.title)
                    .font(.title2)
                    .background(
                        Color.accentColor
                            .frame(height: 6)
                            .offset(y: 24)
                    )

                Spacer()
                
                Button(action: {
                    isLiked.toggle()
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .fontWeight(.heavy)
                }
                
                Button(action: {
                    shareVideo()
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .fontWeight(.heavy)
                }
            }//: HSTACK
        }//: VSTACK
        .padding(16)
        .background(
            colorScheme == .dark ? Color.black : Color.white
        )
        .cornerRadius(10)
        .shadow(radius: 3)
    }
    
    func shareVideo() {
        if let videoURL = URL(string: video.videoUrl) {
            let activityViewController = UIActivityViewController(
                activityItems: [videoURL],
                applicationActivities: nil
            )
            
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                activityViewController.popoverPresentationController?.sourceView = viewController.view
            }
            
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
}
    
    struct ConteudosView_Previews: PreviewProvider {
        static var previews: some View {
            ConteudosView()
        }
    }

