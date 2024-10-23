//
//  proyectoRetoApp.swift
//  proyectoReto
//
//  Created by Pedr1p on 12/10/24.
//

import SwiftUI

@main
struct proyectoRetoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            InicioView()
        }
    }
}
