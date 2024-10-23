//
//  vistaInicio.swift
//  proyectoReto
//
//  Created by Pedr1p on 13/10/24.
//

import SwiftUI

struct InicioView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Rectangle()
                    .fill(.teal)
                    .frame(width: 500, height: 40)
                    .padding()
                
                NavigationLink(destination: ContentViewMapas()) {
                    Text("Entrar")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
                Rectangle()
                    .fill(.teal)
                    .frame(width: 500, height: 40)
                    .padding()
                HStack {
                    VStack {
                        Text("Eventos")
                            .frame(width: 150, height: 150)
                            .background(Rectangle().fill(Color.cyan))
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                        
                        Text("Novedades")
                            .padding()
                            .frame(width: 150, height: 150)
                            .background(Rectangle().fill(Color.green))
                            .foregroundColor(.white)
                            .font(.title2)
                            .bold()
                    }
                    VStack {
                        NavigationLink(destination: ContentView()) {
                            Text("Medallas")
                                .frame(width: 150, height: 150)
                                .background(Rectangle().fill(Color.yellow))
                                .foregroundColor(.white)
                                .font(.title)
                                .bold()
                        }
                        Text("Tutorial")
                            .frame(width: 150, height: 150)
                            .background(Rectangle().fill(Color.orange))
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                    }
                }
                Spacer()
                Rectangle()
                    .fill(.teal)
                    .frame(width: 500, height: 40)
                    .padding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Inicio")
        }
    }
}


#Preview {
    InicioView()
}



