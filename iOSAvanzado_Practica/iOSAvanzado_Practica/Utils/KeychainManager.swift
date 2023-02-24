//
//  KeychainManager.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 23/2/23.
//

import Foundation
import Security

struct KeychainManager {
    
    static let shared = KeychainManager()
    
    func deleteData(key: String) {
        
        // Preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        // ejecutamos la consulta para eliminar
        if (SecItemDelete(query as CFDictionary)) == noErr {
            debugPrint("Información del usuario eliminada con éxito")
        } else {
            debugPrint("Se produjo un error al eliminar la información del usuario")
        }
    }
    
    func updateData(key: String, value: String) {
        
        // Preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        // Preparamos los atributos necesarios
        let attributes: [String: Any] = [
            kSecValueData as String: value.data(using: .utf8)!
        ]
        
        if (SecItemUpdate(query as CFDictionary, attributes as CFDictionary)) == noErr {
            debugPrint("Información del usuario actualizada con éxito")
        } else {
            debugPrint("Se produjo un error al actualizar la información del usuario")
        }
        
    }
    
    func readData(key: String) -> String? {
        
        // Preparamos la consulta
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            
            // extraemos la información
            if let existingItem = item as? [String: Any],
               let valueData = existingItem[kSecValueData as String] as? Data,
               let value = String(data: valueData, encoding: .utf8) {
                
                return value
            }
            return nil
            
        } else {
            return nil
        }
    }
    
    func saveData(key: String, value: String) {
        
        // Preparamos los atributos necesarios
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: value.data(using: .utf8)!
        ]
        
        // Guardar el usuario
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            debugPrint("Información del usuario guardada con éxito")
        } else {
            debugPrint("Se produjo un error al guardar la información del usuario")
        }
    }
}
