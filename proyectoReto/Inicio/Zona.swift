//
//  Zona.swift
//  proyectoReto
//
//  Created by Pedr1p on 14/10/24.
//

import Foundation

// Struct de la Zona
// Contiene ID autogenerado, nombre de la zona, imagen (hardcodeada), booleano que mide si se completo

struct Zona: Identifiable, Codable {
    var id = UUID()
    var nombre: String
    var imagen: String
    var completado: Bool
}

