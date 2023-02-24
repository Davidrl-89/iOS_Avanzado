//
//  DetailViewController.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 22/2/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroeName: UILabel!
    @IBOutlet weak var heroeDescription: UITextView!
    
    private var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = hero?.name
        
        guard let hero = hero else { return }
        let url = URL(string: hero.photo)
        guard let url = url else { return }
        
        self.heroImage.setImage(url: url)
        self.heroeName.text = hero.name
        self.heroeDescription.text = hero.description
    }
    
    func set(model: Hero) {
        hero = model
    }
}
