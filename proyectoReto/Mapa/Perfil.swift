//
//  Perfil.swift
//  proyectoReto
//
//  Created by user254414 on 10/28/24.
//

import SwiftUI

struct Perfil: View {
    @State private var navegarASignIn = false
    var body: some View {
        NavigationStack{
            VStack{
                Button{
                    borrarUsuario()
                    navegarASignIn = true
                }label:{
                    Text("Cerrar Sesion")
                }
            }
            .navigationTitle("Perfil")
            .navigationDestination(isPresented: $navegarASignIn) {
                SignIn()
            }
        }
    }
}

#Preview {
    Perfil()
}

func borrarUsuario() {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("sesion.json")
    
    guard let url = fileURL else { return }
    
    do {
        // Guardamos un JSON vacío
        try "{}".write(to: url, atomically: true, encoding: .utf8)
        print("El archivo de sesión ha sido limpiado.")
    } catch {
        print("Error al intentar limpiar el archivo de sesión: \(error.localizedDescription)")
    }
}
