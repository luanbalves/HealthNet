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
                    VideoPlayer(player: AVPlayer(url: URL(string: video.videoUrl)!))
                        .frame(height: 250)
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

struct ConteudosView_Previews: PreviewProvider {
    static var previews: some View {
        ConteudosView()
    }
}
