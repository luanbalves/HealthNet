//
//  RegistrationView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 09/09/23.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("MedConnect")
                .fontWeight(.bold)
                .font(.system(size: 38))
                .foregroundColor(.green)
                .padding(.vertical, 38)
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email",
                          placerHolder: "nome@exemplo.com")
                .autocapitalization(.none)
                
                InputView(text: $fullname,
                          title: "Nome completo",
                          placerHolder: "Digite seu nome")
                
                InputView(text: $password,
                          title: "Senha",
                          placerHolder: "Digite sua senha",
                          isSecureField: true)
                
                InputView(text: $confirmPassword,
                          title: "Confirme sua senha",
                          placerHolder: "Repita sua senha",
                          isSecureField: true)
            }//: Vstack
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                   password:password,
                                                   fullname: fullname)
                }
            } label: {
                HStack {
                    Text("REGISTRAR")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }//: HSTACK
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }//: BUTTON
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 24)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Já tem uma conta?")
                    Text("Entrar")
                        .fontWeight(.bold)
                }//: HSTACK
                .font(.system(size: 14))
            }

        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
