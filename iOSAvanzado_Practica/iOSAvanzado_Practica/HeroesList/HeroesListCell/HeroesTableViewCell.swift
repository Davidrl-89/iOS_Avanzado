//
//  HeroesTableViewCell.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import UIKit

class HeroesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroeImage: UIImageView!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeDescription: UILabel!
    
    func setHero(model:Hero) {
        self.heroeName.text = model.name
        self.heroeDescription.text = model.description
        let url = URL(string: model.photo)
        guard let url = url  else {return}
        self.heroeImage.setImage(url: url)
    }
}
