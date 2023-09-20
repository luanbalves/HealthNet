//
//  ProfileView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 09/09/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    
                    //MARK: - PROFILE
                    
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                                .tint(.primary)
                            
                            Text(user.email)
                                .font(.footnote)
                                .tint(.primary)
                        }//: VSTACK
                    }//: HSTACK
                    
                }//: SECTION
                
                //MARK: - OTHER INFORMATIONS AND FUNCTIONALITIES
                
                Section("Geral") {
                    HStack {
                        SettingsRowView(imageName: "gear",
                                        title: "Versão",
                                        tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }//: HSTACK
                }//: SECTION
                
                Section("Conta") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sair",
                                        tintColor: .red)
                    }
                    
                }//: SECTION
                
            }
        }//: LIST
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
