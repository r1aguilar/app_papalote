//
//  zonaManager.swift
//  proyectoReto
//
//  Created by Pedr1p on 14/10/24.
//

import Foundation
import Combine

class ZonaManager: ObservableObject {
    @Published var zonas: [Zona] = [
        Zona(nombre: "Pertenezco", imagen: "iconos papalote zonas", completado: false),
        Zona(nombre: "Comprendo", imagen: "comprendo", completado: false),
        Zona(nombre: "Soy", imagen: "soy", completado: false),
        Zona(nombre: "Comunico", imagen: "comunico", completado: false),
        Zona(nombre: "Peque", imagen: "peque", completado: false),
        Zona(nombre: "Expreso", imagen: "expreso", completado: false)
    ]
    
    // Función para resetear el progreso de todas las zonas
    func resetProgreso() {
        for i in 0..<zonas.count {
            zonas[i].completado = false
        }
        saveState() // Guardar el estado después de resetear
    }
    
    // Guardar el estado de las zonas en un archivo local
    func saveState() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(zonas) {
            let url = getDocumentsDirectory().appendingPathComponent("zonas2.json")
            try? data.write(to: url)
        }
    }
    
    // Conseguir el directorio
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    // Cargar el savefile para mantener la progresion
    func loadState() {
        let decoder = JSONDecoder()
        let url = getDocumentsDirectory().appendingPathComponent("zonas2.json")
        if let data = try? Data(contentsOf: url), let loadedZonas = try? decoder.decode([Zona].self, from: data) {
            zonas = loadedZonas
        }
    }
    func toggleZona(_ zona: Zona) {
        if let index = zonas.firstIndex(where: { $0.id == zona.id }) {
            zonas[index].completado.toggle()
            saveState()
        }
    }
}
