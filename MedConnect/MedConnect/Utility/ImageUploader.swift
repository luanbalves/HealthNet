//
//  ImageUploader.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 26/10/23.
//

import UIKit
import Firebase
import FirebaseStorage

class ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = NSUUID().uuidString
        let ref =  Storage.storage().reference(withPath: "/news_images/\(filename)")
        
        do {
            let _ = try await ref.putDataAsync(imageData)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("\(error.localizedDescription)")
            return nil
        }
        
    }
    
}

