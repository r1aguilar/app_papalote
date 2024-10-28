import Foundation

struct Zona2: Identifiable, Codable {
    var id: Int
    var nombre: String
    var completado: Bool
    var imagen: String
}

class ZonasData: ObservableObject {
    @Published var zonas: [Zona2] = [
        Zona2(id: 1, nombre: "Expreso", completado: false, imagen: "expreso"),
        Zona2(id: 2, nombre: "Comunico", completado: false, imagen: "comunico"),
        Zona2(id: 3, nombre: "Pertenezco", completado: false, imagen: "iconos papalote zonas"),
        Zona2(id: 4, nombre: "Comprendo", completado: false, imagen: "comprendo"),
        Zona2(id: 5, nombre: "Soy", completado: false, imagen: "soy"),
        Zona2(id: 6, nombre: "Pequenos", completado: false, imagen: "peque")
    ] {
        didSet {
            saveState()
        }
    }
    
    init() {
        loadState()  // Carga el estado guardado cuando se inicia la app
    }

    func saveState() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(zonas) {
            let url = getDocumentsDirectory().appendingPathComponent("zonas2.json")
            try? data.write(to: url)
        }
    }

    func loadState() {
        let url = getDocumentsDirectory().appendingPathComponent("zonas2.json")
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decodedZonas = try? decoder.decode([Zona2].self, from: data) {
                zonas = decodedZonas
            }
        }
    }

    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}


    

