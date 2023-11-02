//
//  ContentProfileView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 02/11/23.
//

import SwiftUI

struct ContentProfileView: View {
    
    let headingImage: String
    let headingText: String
    
    var body: some View {
        Group {
            HStack {
                HeadingView(headingImage: headingImage, headingText: headingText)
               
                Button {
                    print("")
                } label: {
                    Image(systemName: "arrow.forward")
                }

            }//: HSTACK
                                        
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 15) {
                    ForEach(0..<5, id: \.self) { _ in
                        VStack {
                            Image("img")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .cornerRadius(12)
                            Text("Titulo")
                                .fontWeight(.heavy)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 8)
                        }//: VSTACK
                    }//: LOOP
                    .background(Color.primary.opacity(0.18))
                    .cornerRadius(12)
                    .shadow(radius: 25)
                    .padding(.horizontal)
                }//: HSTACK
            }//: SCROLL
        }//: GROUP
    }
}

struct ContentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ContentProfileView(headingImage: "play.rectangle", headingText: "Videos")
    }
}
