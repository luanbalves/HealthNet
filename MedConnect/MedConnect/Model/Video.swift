//
//  Video.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 08/10/23.
//

import Foundation

struct Video: Identifiable, Decodable {
    let videoUrl: String
    var title: String
    var id: String {
        return NSUUID().uuidString
    }
}
