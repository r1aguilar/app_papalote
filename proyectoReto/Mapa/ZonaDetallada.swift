import SwiftUI

struct ZonaDetallada: View, Identifiable {
    var id: UUID = UUID() // Identificador único
    var TituloZona: String
    var idZona: Int
    var enfocarActividadId: Int? // ID de actividad a enfocar
    
    @Environment(\.dismiss) private var dismiss

    // Filtrar las actividades por la zona seleccionada
    var actividadesFiltradas: [Actividad2] {
        Actividad2.datosEjemplo.filter { $0.idZona == idZona }
    }

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in // Agregar ScrollViewReader
                VStack {
                    // Botón de retroceso y título
                    ZStack {
                        Button(action: {
                            dismiss() // Cierra la vista actual
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color(white: 0.85))
                                .clipShape(Circle())
                        }
                        .offset(x: -UIScreen.main.bounds.width/2 + 35)
                        Text(pathDictionary[TituloZona]?.1 ?? "Rara")
                            .font(.system(size: 35))
                            .bold()
                    }
                    
                    // Lista de actividades con fondo de color
                    ZStack {
                        (pathDictionary[TituloZona]?.0 ?? Color(white: 0.75))
                            .edgesIgnoringSafeArea(.all)
                        
                        List(actividadesFiltradas) { actividad in
                            NavigationLink(destination: TemplateActividad2(unaActividad: actividad)) {
                                CeldaJugador(unaActividad: actividad, idZona: idZona, isHighlighted: actividad.idActividad == enfocarActividadId)
                                    .padding(.vertical, 8)
                                    .shadow(radius: 1)
                                    .padding(.horizontal)
                            }
                            .id(actividad.idActividad) // Añadir un ID a cada celda
                            .listRowBackground(Color.clear) // Hace el fondo de la lista transparente
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(PlainListStyle()) // Estilo limpio para la lista
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Spacer()
                    
                    // Footer con botón "Ir a la vista de mapa"
                    NavigationLink(destination: MapaDetalladoZona()) {
                        Text("Ir a la vista de mapa")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 220)
                            .background(colores[idZona]!)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    if let enfocarId = enfocarActividadId {
                        proxy.scrollTo(enfocarId, anchor: .center)
                    }
                }
            }
        }
    }
}

struct CeldaJugador: View {
    var unaActividad: Actividad2
    var idZona: Int
    var isHighlighted: Bool // Propiedad para determinar si se debe resaltar

    var body: some View {
        HStack {
            Text("\(unaActividad.idActividad)")
                .font(.system(size: 30))
                .foregroundStyle(colores[idZona]!)
                .frame(width: 35)
                .background(Color(white: 0.85))
                .clipShape(Circle())
                .offset(x: (UIScreen.main.bounds.width / 2) - 210)
            Text(unaActividad.nombre)
                .font(.headline)
                .foregroundColor(.black)
                .bold()
            Spacer()
        }
        .padding(.vertical, 10)
        .overlay(
            isHighlighted ? RoundedRectangle(cornerRadius: 10)
                .stroke(Color.yellow, lineWidth: 4) // Borde iluminado
                : nil
        )
    }
}

#Preview {
    ZonaDetallada(TituloZona: "Pertenezco", idZona: 2, enfocarActividadId: 1)
}
