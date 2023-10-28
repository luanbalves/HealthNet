//
//  NoticiasViewModel.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 26/10/23.
//

import Foundation
import Firebase
import SwiftUI
import PhotosUI

@MainActor
class NoticiasViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    @Published var news = [Noticia]()
    
    @Published var searchText = ""
    
    var filteredNews: [Noticia] {
        if searchText.isEmpty {
            return news
        } else {
            return news.filter{ $0.newsTitle.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init() {
        Task { try await fetchNews() }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadNews(newsTitle: String, newsText: String, subtitle: String, imageSubtitle: String) async throws {
        guard let uiImage = uiImage else { return }
        
        let newsRef = Firestore.firestore().collection("news").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let news = Noticia(id: newsRef.documentID, newsTitle: newsTitle, newsText: newsText, selectedImage: imageUrl, subtitle: subtitle, imageSubtitle: imageSubtitle)
        guard let encodedNews = try? Firestore.Encoder().encode(news) else { return }
        try await newsRef.setData(encodedNews)
    }
    
    
    func fetchNews() async throws {
        let snapshot = try await Firestore.firestore().collection("news").getDocuments()
        self.news = try snapshot.documents.compactMap({ try $0.data(as: Noticia.self ) })
    }
}

