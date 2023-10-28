//
//  Noticia.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 26/10/23.
//

import Foundation

struct Noticia: Identifiable, Codable {
    var id: String
    var newsTitle: String
    var newsText: String
    var selectedImage: String
    var subtitle: String
    var imageSubtitle: String
//    var selectedPhotos: [String?] 
}
