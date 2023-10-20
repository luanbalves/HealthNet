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
            
            NavigationView {
                VStack {
                    
                    //MARK: - OTHER INFORMATIONS AND FUNCTIONALITIES
                    
    //                HStack {
    //                    Button {
    //                        viewModel.signOut()
    //                    } label: {
    //                        Text("Sair")
    //                            .font(.headline)
    //                            .foregroundColor(.red)
    //                            .frame(maxWidth: .infinity, alignment: .leading)
    //                    }//: BUTTON
    //                    .padding()
    //
    //                    Spacer()
    //
    //                    Button {
    //                        // EditProfileView()
    //                    } label: {
    //                        Text("Editar perfil")
    //                            .font(.headline)
    //                            .foregroundColor(.blue)
    //                            .frame(maxWidth: .infinity, alignment: .trailing)
    //                    }//: BUTTON
    //                    .padding()
    //
    //                }//: HSTACK
                    
                    HStack {
                        Button {
                            viewModel.signOut()
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "arrow.left.circle.fill")
                                    .imageScale(.small)
                                    .font(.title)
                                    .foregroundColor(.red)
                                Text("Sair")
                                    .foregroundColor(.primary)
                                    .font(.headline)
                            }//: HSTACK
                        }//: BUTTON
                        
                        Spacer()
                        
                        NavigationLink {
                            EditProfileView()
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: "person.text.rectangle")
                                    .imageScale(.small)
                                    .font(.title)
                                    .foregroundColor(.blue)
                                Text("Editar perfil")
                                    .foregroundColor(.primary)
                                    .font(.headline)
                            }//: HSTACK
                        }//: NAVLINK
                        
                    }//: HSTACK
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 6, trailing: 16))
                    
                    //MARK: - PROFILE
                    
                    HStack(spacing: 15) {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 86, height: 86)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullname)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.top, 4)
                                .tint(.primary)
                            
                            Text(user.status)
                                .font(.footnote)
                                .tint(.primary)
                            
                            if(user.status == "Médico") {
                                Text("CRM: \(user.crm!)")
                                    .font(.footnote)
                                    .tint(.primary)
                            }
                            
                            Text("@Exemplo")
                                .font(.footnote)
                                .tint(.primary)
                                .fontWeight(.semibold)
                            
                            
                        }//: VSTACK
                    }//: HSTACK
                    
                    HStack(spacing: 35) {
                        VStack {
                            Text("Seguidores")
                                .font(.title3)
                            
                            Text("37")
                        }
                        
                        VStack {
                            Text("Seguindo")
                                .font(.title3)
                            
                            Text("77")
                        }
                        
                        VStack {
                            Text("Curtidas")
                                .font(.title3)
                            
                            Text("999")
                        }
                        
                    }//: HSTACK
                    .padding(.top, 20)
                    
                    Spacer()
                                    
                }//: VSTACK
            }//: NAVVIEW
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        //        ProfileView()
        //            .environmentObject(AuthViewModel())
        let viewModel = AuthViewModel()
        viewModel.currentUser = User(id: "exemploID", fullname: "Nome de Exemplo", email: "exemplo@email.com", status: "Médico", crm: "123456")
        return ProfileView()
            .environmentObject(viewModel)
    }
}
