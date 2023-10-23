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
    @State private var selectedStatus = "Vestibulando"
    @State private var crm = ""
    @State private var user = ""
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    let statusOptions = ["Vestibulando", "Estudante", "Médico"]
    
    var body: some View {
        VStack {
            
            //MARK: - LOGO
            
            Text("HealthNet")
                .fontWeight(.heavy)
                .font(.custom("Avenir-Heavy", size: 38))
                .foregroundColor(.accentColor)
                .padding(.vertical, 38)
            
            //MARK: - FORM
            
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email",
                          placerHolder: "nome@exemplo.com")
                .autocapitalization(.none)
                
                InputView(text: $user,
                          title: "Usuário",
                          placerHolder: "Digite seu usuário")
                
                InputView(text: $fullname,
                          title: "Nome completo",
                          placerHolder: "Digite seu nome")
                
                InputView(text: $password,
                          title: "Senha",
                          placerHolder: "Digite sua senha",
                          isSecureField: true)
                
                ZStack (alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirme sua senha",
                              placerHolder: "Repita sua senha",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }//: ZSTACK
                
                Picker("Status", selection: $selectedStatus) {
                                ForEach(statusOptions, id: \.self) { status in
                                    Text(status)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            if selectedStatus == "Médico" {
                                TextField("CRM", text: $crm)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                
            }//: Vstack
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                   password: password,
                                                   fullname: fullname,
                                                   status: selectedStatus,
                                                   crm: crm,
                                                   user: user
                    )
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
            .background(Color(red: 0.0, green: 0.502, blue: 0.251))            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
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

//MARK: - FORM CONDITIONALS 

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        
        if selectedStatus == "Médico" {
            return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
            && confirmPassword == password
            && !fullname.isEmpty
            && (!crm.isEmpty || selectedStatus != "Médico")
            
        } else {
            return !email.isEmpty
            && email.contains("@")
            && !password.isEmpty
            && password.count > 5
            && confirmPassword == password
            && !fullname.isEmpty
            && !user.isEmpty
            && !user.contains("@")
        }
        
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
