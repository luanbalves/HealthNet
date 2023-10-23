//
//  User.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 09/09/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let status: String
    let crm: String?
    let user: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Stephen Curry", email: "Steph@gmail.com", status: "Estudante", crm: "", user: "@Stephen")
}
