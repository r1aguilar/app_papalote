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
                                .init(color: colores[unaActividad.idZona]!.opacity(0.6), location: 0),
                                .init(color: colores[unaActividad.idZona]!.opacity(0.4), location: 1)]
                                ),
                                startPoint: .topLeading, // Start from the top left corner
                                endPoint: .bottomTrailing // End at the bottom right corner
                        ))
                        .mask(LinearGradient(
                        gradient: Gradient(
                        stops: [.init(color: .black, location: 0.4),
                        .init(color: .black.opacity(0), location: 0.8)]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 1200) // Set your desired height
            }
            .edgesIgnoringSafeArea(.all)

            // Main content with sticky header
            VStack {
                // Sticky header for activity name
                Text(unaActividad.nombre)
                    .padding()
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(colores[unaActividad.idZona]!)
                    .zIndex(1) // Make sure it stays on top

                ScrollView {
                    VStack {
                        // Renderiza las tarjetas de la actividad
                        ForEach(unaActividad.listaTarjetas, id: \.idTarjeta) { tarjeta in
                            tarjetaView(tarjeta: tarjeta, actividad: unaActividad)
                        }
                    }
                    .padding(.bottom) // Optional padding to avoid content being cut off
                }
                .scrollIndicators(.hidden) // Hide scroll indicators
            }
            .padding(.top, 5) // Padding to push the content below the gradient
        }
    }

    private func tarjetaView(tarjeta: Tarjeta, actividad: Actividad2) -> some View {
        let cardWidth: CGFloat = UIScreen.screenWidth - 50 // Adjust width as needed

        switch tarjeta.tipo {
        case 1:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.7))
                        .frame(minWidth: cardWidth)
                        .shadow(color: Color(white: 0.96), radius: 2)
                    Text(tarjeta.texto ?? "")
                        .font(.headline)
                        .padding()
                }
                .frame(width: cardWidth) // Width applied to the container
            )
        case 2:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.7))
                        .shadow(color: Color(white: 0.96), radius: 2)
                        .frame(minWidth: cardWidth)
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
                    .padding(8)
                }
                .frame(width: cardWidth) // Width applied to the container
            )
        case 3:
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.7))
                        .shadow(color: Color(white: 0.96), radius: 2)
                        .frame(minWidth: cardWidth)
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
                    // Background circle
                    Circle()
                        .fill(colores[unaActividad.idZona]!) // Use the color for the background
                        .frame(width: cardWidth, height: cardWidth) // Slightly larger than the image

                    // Image
                    if let imagenUrl = tarjeta.imagenUrl, let url = URL(string: imagenUrl) {
                        CacheAsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: cardWidth, height: cardWidth) // Placeholder size
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle()) // Ensure the image is also circular
                                    .frame(width: cardWidth-20, height: cardWidth-20) // Set size for the image
                            case .failure(let error):
                                Text("Error loading image: \(error)")
                                    .frame(width: cardWidth, height: cardWidth) // Placeholder size
                            @unknown default:
                                fatalError()
                            }
                        }
                    } else {
                        EmptyView()
                    }
                }
                .frame(width: cardWidth, height: cardWidth) // Width applied to the container
                .padding(8)
            )

        default:
            return AnyView(EmptyView())
        }
    }

}

#Preview {
    TemplateActividad2(unaActividad: Actividad2(idActividad: 3, idZona: 2, nombre: "PEPE", listaTarjetas: Tarjeta.datosEjemplo))
}
