//
//  HeroModel.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import UIKit

struct Hero: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
}
