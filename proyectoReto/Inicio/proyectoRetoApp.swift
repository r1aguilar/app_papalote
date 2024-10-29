//
//  proyectoRetoApp.swift
//  proyectoReto
//
//  Created by Pedr1p on 12/10/24.
//

import SwiftUI
import Foundation

@main
struct proyectoRetoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var usuario: user?
    
    init() {
        _ = ActividadesDataManager.shared
        // Necesitamos usar _usuario para modificar el State directamente en init
        _usuario = State(initialValue: cargarUsuarioInicial())
    }
    
    var body: some Scene {
        WindowGroup {
            if let usuario = usuario {
                InicioView()
            } else {
                SignIn()
            }
        }
    }
    
    private func cargarUsuarioInicial() -> user? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("sesion.json")
        
        guard let url = fileURL else {
            print("No hace el url")
            return nil
        }
        
        do {
            let datosRecuperados = try Data(contentsOf: url)
            if let jsonString = String(data: datosRecuperados, encoding: .utf8) {
                print("Contenido del archivo JSON: \(jsonString)")
            }
            
            let decoder = JSONDecoder()
            let usuarioCargado = try decoder.decode(user.self, from: datosRecuperados)
            print("Usuario cargado exitosamente: \(usuarioCargado)")
            return usuarioCargado
        } catch {
            print("Error cargando usuario: \(error)")
            return nil
        }
    }
}
