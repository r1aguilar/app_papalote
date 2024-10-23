//
//  ContentView.swift
//  proyectoReto
//
//  Created by Pedr1p on 12/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var zonaManager = ZonaManager()
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Text("Menu de Medallas")
                        .font(.title)
                        .bold()
                        .padding()
                    Text("Las zonas que tengan un borde amarillo a su alrededor, han sido completadas 100%")
                    Divider()
                    
                    HStack {
                        VStack {
                            // Para cada de las zonas (1 a 3) se despliega su imagen correspondiente, y en caso de haberla completado, su marco
                            ForEach(zonaManager.zonas.prefix(3)) { zona in
                                NavigationLink(destination: vistaPertenezco(zonaManager: zonaManager, zona: zona)) {
                                    Image(zona.imagen)
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(zona.completado ? Color.yellow : Color.clear, lineWidth: 10))
                                }
                            }
                        }
                        // Segunda mitad de zonas desplegadas, todas son botones (navigation link) que llevan a la "vistaPertenezco" que deberia de ser vista zona, es placeholder
                        VStack {
                            ForEach(zonaManager.zonas.dropFirst(3)) { zona in
                                NavigationLink(destination: vistaPertenezco(zonaManager: zonaManager, zona: zona)) {
                                    Image(zona.imagen)
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(zona.completado ? Color.yellow : Color.clear, lineWidth: 10))
                                }
                            }
                        }
                    }
                    .padding()
                }
                //Cargar los saves
                .onAppear {
                    zonaManager.loadState()
                }
            }
        }
    }
}


#Preview{
    ContentView()
}

