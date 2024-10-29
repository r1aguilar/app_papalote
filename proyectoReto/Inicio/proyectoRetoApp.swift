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
    @State private var usuario: user? = nil

    init() {
        _ = ActividadesDataManager.shared
        usuario = cargarUsuario() // Cargar usuario en la inicialización
    }
    
    var body: some Scene {
        WindowGroup {
            if let usuario = usuario {
                InicioView() // Vista para usuarios existentes
            } else {
                SignIn() // Vista de inicio de sesión
            }
        }
    }
}

func cargarUsuario() -> user? {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("sesion.json")
    
    guard let url = fileURL else { return nil }
    
    if let datosRecuperados = try? Data(contentsOf: url) {
        let decoder = JSONDecoder()
        if let usuario = try? decoder.decode(user.self, from: datosRecuperados) {
            return usuario
        }
    }
    return nil
}
