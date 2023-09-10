//
//  ProfileView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 09/09/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section {
                
                HStack {
                    Text(User.MOCK_USER.initials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(User.MOCK_USER.fullname)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text(User.MOCK_USER.email)
                            .font(.footnote)
                            .tint(.gray)
                    }//: VSTACK
                }//: HSTACK
                
            }//: SECTION
            
            Section("Geral") {
                HStack {
                    SettingsRowView(imageName: "gear",
                                    title: "Versão",
                                    tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }//: HSTACK
            }//: SECTION
            
            Section("Conta") {
                Button {
                    print("Deslogar")
                } label: {
                    SettingsRowView(imageName: "arrow.left.circle.fill",
                                    title: "Sair",
                                    tintColor: .red)
                }

                Button {
                    print("Deletar")
                } label: {
                    SettingsRowView(imageName: "xmark.circle.fill",
                                    title: "Deletar conta",
                                    tintColor: .red)
                }
                
            }//: SECTION
            
        }//: LIST
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
