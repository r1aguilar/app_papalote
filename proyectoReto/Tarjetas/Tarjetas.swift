//
//  Tarjetas.swift
//  proyectoReto
//
//  Created by Alumno on 18/10/24.
//

import Foundation

// Clase que representa una Tarjeta
struct Tarjeta: Codable {
    let idTarjeta: Int
    let tipo: Int
    let texto: String?
    let imagenUrl: String?
    let ordenLista: Int

    // CodingKeys para mapear las propiedades al JSON
    enum CodingKeys: String, CodingKey {
        case idTarjeta = "id_tarjeta"
        case tipo
        case texto
        case imagenUrl = "imagen_url"
        case ordenLista = "orden_lista"
    }
}

// Clase que representa una Actividad
struct Actividad2: Identifiable, Codable {
    let id = UUID()
    let idActividad: Int
    let idZona: Int
    let nombre: String
    let listaTarjetas: [Tarjeta]

    // CodingKeys para mapear las propiedades al JSON
    enum CodingKeys: String, CodingKey {
        case idActividad = "id_actividad"
        case idZona = "id_zona"
        case nombre
        case listaTarjetas = "lista_tarjetas"
    }
}

extension Tarjeta {
    static let datosEjemplo = [
        Tarjeta(idTarjeta: 1, tipo: 4, texto: "¡Es tu turno!", imagenUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png", ordenLista: 1),
        Tarjeta(idTarjeta: 2, tipo: 3, texto: "Sigue apilando las piezas.", imagenUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png", ordenLista: 2),
        Tarjeta(idTarjeta: 3, tipo: 2, texto: "¿Listo para el desafío?", imagenUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/132.png", ordenLista: 3),
        Tarjeta(idTarjeta: 4, tipo: 1, texto: "Cuidado, se puede caer.", imagenUrl: "", ordenLista: 4)
    ]
}

extension Actividad2 {
    static let datosEjemplo = [
        Actividad2(idActividad: 1, idZona: 3, nombre: "JENGA", listaTarjetas: Tarjeta.datosEjemplo),
        Actividad2(idActividad: 2, idZona: 3, nombre: "SUCULENTAS", listaTarjetas: [
            Tarjeta(idTarjeta: 5, tipo: 1, texto: "Elige tu suculenta.", imagenUrl: "", ordenLista: 1),
            Tarjeta(idTarjeta: 6, tipo: 1, texto: "Agrega color a tu creación.", imagenUrl: "", ordenLista: 2)
        ]),
        Actividad2(idActividad: 3, idZona: 5, nombre: "SUPERMERCADO", listaTarjetas: [
            Tarjeta(idTarjeta: 7, tipo: 1, texto: "Compra los ingredientes.", imagenUrl: "", ordenLista: 1),
            Tarjeta(idTarjeta: 8, tipo: 1, texto: "No olvides la lista.", imagenUrl: "", ordenLista: 2)
        ]),
        Actividad2(idActividad: 4, idZona: 1, nombre: "VIENTO", listaTarjetas: [
            Tarjeta(idTarjeta: 9, tipo: 1, texto: "Observa lo que vuela.", imagenUrl: "", ordenLista: 1),
            Tarjeta(idTarjeta: 10, tipo: 1, texto: "¿A dónde llevará el viento?", imagenUrl: "", ordenLista: 2)
        ]),
        Actividad2(idActividad: 5, idZona: 2, nombre: "RADIO", listaTarjetas: [
            Tarjeta(idTarjeta: 9, tipo: 1, texto: "Imagina que eres un locutor.", imagenUrl: "", ordenLista: 1),
            Tarjeta(idTarjeta: 10, tipo: 1, texto: "¿Que le dirias al mundo?", imagenUrl: "", ordenLista: 2)
        ]),
        Actividad2(idActividad: 6, idZona: 6, nombre: "SUBMARINO", listaTarjetas: [
            Tarjeta(idTarjeta: 9, tipo: 1, texto: "Sumergente en una aventura.", imagenUrl: "", ordenLista: 1),
            Tarjeta(idTarjeta: 10, tipo: 1, texto: "¿A dónde llevará el subsuelo?", imagenUrl: "", ordenLista: 2)
        ]),
        Actividad2(idActividad: 7, idZona: 4, nombre: "BAYLAB", listaTarjetas: [
            Tarjeta(idTarjeta: 9, tipo: 1, texto: "Aprende a experimentar como nunca antes.", imagenUrl: "", ordenLista: 1),
            Tarjeta(idTarjeta: 10, tipo: 1, texto: "Una experiencia inolvidable!", imagenUrl: "", ordenLista: 2)
        ])]
}

