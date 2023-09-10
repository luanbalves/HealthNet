//
//  InputView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 09/09/23.
//

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placerHolder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placerHolder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placerHolder, text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
            
        }//: VSTACK
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email", placerHolder: "name@exemplo.com")
    }
}
