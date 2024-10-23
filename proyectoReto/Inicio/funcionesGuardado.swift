//
//  funcionesGuardado.swift
//  proyectoReto
//
//  Created by Pedr1p on 13/10/24.
//

import Foundation

class StateManager {
    static let shared = StateManager()
    private let fileName = "appState.json"
    
    private init() {}
    
    func saveState(state: AppState) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(state) {
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            try? data.write(to: url)
        }
    }
    
    func loadState() -> AppState? {
        let decoder = JSONDecoder()
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        if let data = try? Data(contentsOf: url), let state = try? decoder.decode(AppState.self, from: data) {
            return state
        }
        return nil
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
