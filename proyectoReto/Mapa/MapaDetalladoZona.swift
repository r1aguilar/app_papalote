import SwiftUI
import InteractiveMap

struct MapaDetalladoZona: View {
    @State private var clickedPath = PathData()
    @State private var svgName = "RojoDetalladoSvg2" // Default SVG name
    @State private var textScale: CGFloat = 1.0 // Control del tamaño del texto
    @State private var orientation = UIDeviceOrientation.portrait
       
       init() {
           // Force the application to remain in portrait mode
           UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
           AppDelegate.orientationLock = .portrait
       }
    
    var body: some View {
        ZStack {
            Color.white
            
            // Mostrar el nombre capitalizado solo si es un path válido y no es "undefined"
            if clickedPath.name != "undefined", !clickedPath.name.isEmpty {
                Text(capitalizeFirstLetter(clickedPath.name))
                    .rotationEffect(.degrees(270))
                    .font(.largeTitle)
                    .bold()
                    .offset(x: -UIScreen.screenWidth / 2 + 35)
                    .scaleEffect(textScale) // Aplica el efecto de escala
                    .animation(.easeInOut(duration: 0.2), value: textScale) // Añade animación
                    .onAppear {
                        textScale = 1.2 // Aumenta el tamaño del texto
                    }
                    .onChange(of: clickedPath.name) { _ in
                        textScale = 1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            textScale = 1.0
                        }
                    }
            }

            HStack {
                interactiveMapView(svgName: svgName)
                    .rotationEffect(.degrees(180)) // Rota el mapa 180 grados
                    .contentShape(Rectangle()) // Asegura que el área completa sea clickeable
                    .onTapGesture {
                        // Establece clickedPath a un valor vacío si se hace clic fuera de un path
                        clickedPath = PathData(name: "", id: "", path: [])
                    }
            }
            .padding(.vertical, UIScreen.screenWidth / 10)
            .padding(.horizontal, UIScreen.screenWidth / 8)
            .offset(x: UIScreen.screenWidth/2 - 170)
        }
        .ignoresSafeArea()
    }
        
    private func interactiveMapView(svgName: String) -> some View {
        InteractiveMap(svgName: svgName) { pathData in
            InteractiveShape(pathData)
                .stroke(clickedPath == pathData ? pathDictionary[pathData.name]?.0 ?? Color.black.opacity(0.4) : pathDictionary[pathData.name]?.0 ?? Color.black.opacity(0.4))
                .background(InteractiveShape(pathData).fill(pathDictionary[pathData.name]?.0 ?? colores[5]!))
                .onTapGesture {
                    // Establece clickedPath solo si se clickea en un path
                    clickedPath = pathData
                }
        }
        .id(svgName)
    }
    
    // Función para capitalizar la primera letra de una cadena
    private func capitalizeFirstLetter(_ text: String) -> String {
        guard let firstLetter = text.first else { return text }
        return firstLetter.uppercased() + text.dropFirst()
    }
}

#Preview {
    MapaDetalladoZona()
}

