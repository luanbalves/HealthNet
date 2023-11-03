//
//  EditProfileView.swift
//  MedConnect
//
//  Created by Luan Alves Barroso on 19/10/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var updateFullname = ""
    @State private var updateStatus = 0
    @State private var crm = ""

    var status = ["Médico", "Estudante", "Vestibulando"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações do Perfil")) {
                    
                    TextField("Nome Completo", text: $updateFullname)

                    Picker("Status", selection: $updateStatus) {
                        ForEach(0..<status.count, id: \.self) { index in
                            Text(status[index])
                        }
                    }
                    
                    if status[updateStatus] == "Médico" {
                        TextField("CRM", text: $crm)
                    }
                    
                }//: SECTION
                
                Section {
                    Button("Salvar alterações") {
                        // IMPLEMENTAR ALTERAÇÃO
                    }
                    
                }//: SECTION
            }//: FORM
        }//: NAVVIEW
        .navigationTitle("Editar Perfil")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
