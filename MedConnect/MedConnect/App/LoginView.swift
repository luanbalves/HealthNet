//
//  LoginView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 09/09/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                //MARK: - LOGO
                
                Text("MedConnect")
                    .fontWeight(.bold)
                    .font(.system(size: 38))
                    .foregroundColor(.green)
                    .padding(.vertical, 38)
                
                //MARK: - FORM
                
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email",
                              placerHolder: "nome@exemplo.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Senha",
                              placerHolder: "Digite sua senha",
                              isSecureField: true)
                }//: Vstack
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                NavigationLink {
                    ForgetPasswordView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Spacer()
                        Text("Esqueceu sua senha?")
                            .fontWeight(.bold)
                            .font(.system(size: 12))
                    }//: HSTACK
                    .padding(.horizontal, 10)
                }//: BUTTON

                
                // SIGN IN BUTTON
                
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("ENTRAR")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }//: HSTACK
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                }//: BUTTON
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                NavigationLink {
                   RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Não tem uma conta?")
                        Text("Registre-se")
                            .fontWeight(.bold)
                    }//: HSTACK
                    .font(.system(size: 14))
                }//: NAVLINK

                
            }//: Vstack
        }//: NavStack
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
