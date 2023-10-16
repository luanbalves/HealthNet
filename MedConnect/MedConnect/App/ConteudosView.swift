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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.videos) { video in
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
                    PhotosPicker(selection: $viewModel.selectedItem,
                                 matching: .any(of: [.videos, .not(.images)])) {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }//: NAVSTACK
    }
}

struct VideoThumbnailView: View {
    let video: Video
    @Environment(\.colorScheme) var colorScheme
    @State private var isLiked = false
    
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(url: URL(string: video.videoUrl)!))
                .frame(height: 200)
            
            HStack {
                Text("Titulo")
                    .font(.title3)
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
            }
        }
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

