//
//  vistaPertenezco.swift
//  proyectoReto
//
//  Created by Pedr1p on 13/10/24.
//

import SwiftUI

struct vistaPertenezco: View {
    @ObservedObject var zonaManager: ZonaManager
    var zona: Zona

    var body: some View {
        VStack {
            Text("Vista de \(zona.nombre)")
                .font(.title)
                .bold()
            
            Button(action: {
                // Llamamos a la función toggleZona correctamente
                zonaManager.toggleZona(zona)
            }) {
                Text("Actividades Completadas")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // Botón para resetear el progreso
            Button(action: {
                zonaManager.resetProgreso()
            }) {
                Text("Resetear Progreso")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
        }
        .padding()
    }
}
