import SwiftUI

struct TemplateActividad2: View {
    var unaActividad: Actividad2

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(
                            stops: [
                                .init(color: colores[unaActividad.idZona]!.opacity(0.4), location: 0),
                                .init(color: colores[unaActividad.idZona]!.opacity(0.6), location: 0.5)
                            ]
                        ),
                        startPoint: .init(x: 0, y: 0),
                        endPoint: .init(x: 1, y: 1)
                    ))
                    .mask(LinearGradient(
                        gradient: Gradient(
                            stops: [.init(color: .black, location: 0.4),
                                    .init(color: .black.opacity(0), location: 0.8)]
                        ),
                        startPoint: .init(x: 0, y: 0),
                        endPoint: .init(x: 0.33, y: 1)
                    ))
                    .frame(height: 400)
            }
            .edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    Text(unaActividad.nombre)
                        .padding()
                        .bold()
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(colores[unaActividad.idZona]!)

                    // Renderiza las tarjetas de la actividad
                    ForEach(unaActividad.listaTarjetas, id: \.idTarjeta) { tarjeta in
                        tarjetaView(tarjeta: tarjeta)
                    }
                }
            }
        }
    }

    private func tarjetaView(tarjeta: Tarjeta) -> some View {
        let cardWidth: CGFloat = 350 // Adjust width as needed

        switch tarjeta.tipo {
        case 1:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.7))
                        .frame(minWidth: cardWidth)
                        .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.red, lineWidth: 2)
                            )
                    Text(tarjeta.texto ?? "")
                        .font(.headline)
                        .padding()
                }
                .padding(4)
                .frame(width: cardWidth) // Width applied to the container
            )
        case 2:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.7))
                        .frame(minWidth: cardWidth)
                        .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.red, lineWidth: 2)
                            )
                    HStack {
                        Text(tarjeta.texto ?? "")
                            .font(.headline)
                            .padding()

                        if let imagenUrl = tarjeta.imagenUrl, let url = URL(string: imagenUrl) {
                            CacheAsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 100, height: 100) // Placeholder size
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                        
                                case .failure(let error):
                                    Text("Error loading image: \(error)")
                                        .frame(width: 100, height: 100) // Placeholder size
                                @unknown default:
                                    fatalError()
                                }
                            }
                        }
                    }
                    .padding(4)
                }
                .frame(width: cardWidth) // Width applied to the container
            )
        case 3:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.7))
                        .frame(minWidth: cardWidth)
                        .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.red, lineWidth: 2)
                            )
                    HStack {
                        if let imagenUrl = tarjeta.imagenUrl, let url = URL(string: imagenUrl) {
                            CacheAsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 100, height: 100) // Placeholder size
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                case .failure(let error):
                                    Text("Error loading image: \(error)")
                                        .frame(width: 100, height: 100) // Placeholder size
                                @unknown default:
                                    fatalError()
                                }
                            }
                        }

                        Text(tarjeta.texto ?? "")
                            .font(.headline)
                            .padding()
                    }
                    .padding(8)
                }
                .frame(width: cardWidth) // Width applied to the container
            )
        case 4:
            return AnyView(
                ZStack {
                    if let imagenUrl = tarjeta.imagenUrl, let url = URL(string: imagenUrl) {
                        CacheAsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(.circle)
                                    .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.red, lineWidth: 2)
                                        )
                            case .failure(let error):
                                Text("Error loading image: \(error)")
                            @unknown default:
                                fatalError()
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
                .frame(width: cardWidth) // Width applied to the container
                .padding(0)
            )
        default:
            return AnyView(EmptyView())
        }
    }

}

#Preview {
    TemplateActividad2(unaActividad: Actividad2(idActividad: 3, idZona: 2, nombre: "PEPE", listaTarjetas: Tarjeta.datosEjemplo))
}

