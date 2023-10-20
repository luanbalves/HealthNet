//
//  ForgetPasswordView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 17/09/23.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    @State private var alert = false
    
    var body: some View {
        VStack {
            Text("HealthNet")
                .fontWeight(.heavy)
                .font(.custom("Avenir-Heavy", size: 38))
                .foregroundColor(.accentColor)
                .padding(.vertical, 38)
            
                InputView(text: $email, title: "Email", placerHolder: "Digite seu email")
                    .padding(.horizontal)
            
            Button {
                //Falta implementar logica de recuperacao de senha
                print("Recuperar")
                self.alert = true
            } label: {
                HStack {
                    Text("Recuperar Senha")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }//: HSTACK
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }//: BUTTON
            .background(Color(red: 0.0, green: 0.502, blue: 0.251))
            .cornerRadius(10)
            .padding(.top, 24)
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            //Falta verificacao se o email esta cadastrado
            .alert(isPresented: $alert) {
                Alert(
                    title: Text("Email Enviado!"),
                    message: Text("Um email de recuperação de senha foi enviado."),
                    dismissButton: .default(Text("OK"))
                )
            }
            Spacer()
            
            Button {
                dismiss();
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Voltar para Login")
                }//: HSTACK
                .fontWeight(.black)
                .font(.system(size: 16))
            }//: BUTTON


        }//: VSTACK
    }
}

extension ForgetPasswordView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}
 
