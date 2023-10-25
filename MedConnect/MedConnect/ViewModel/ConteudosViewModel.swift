//
//  ConteudosViewModel.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 08/10/23.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestoreSwift

class ConteudosViewModel: ObservableObject {
    @Published var videos = [Video]()
    
    @Published var selectedItem: PhotosPickerItem?
    @Published var videoTitle = ""
    @Published var searchText = ""
    
    var filteredVideos: [Video] {
        if searchText.isEmpty {
            return videos
        } else {
            return videos.filter{ $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init () {
        Task { try await fetchVideos() }
    }
    
    func uploadVideo() async throws {
        guard let item = selectedItem else { return }
        guard let videoData = try await item.loadTransferable(type: Data.self) else { return }
        guard let videoUrl = try await VideoUploader.uploadVideo(withData: videoData) else { return }
        
        try await Firestore.firestore().collection("videos").document().setData(["videoUrl": videoUrl, "title": videoTitle])
    }
    
    @MainActor
    func fetchVideos() async throws {
        let snapshot = try await Firestore.firestore().collection("videos").getDocuments()
        self.videos = snapshot.documents.compactMap({ try? $0.data(as: Video.self)})
    }
}
