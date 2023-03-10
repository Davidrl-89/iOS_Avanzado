//
//  UIImageViewExtension.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import UIKit


typealias ImageCompletion = (UIImage?) -> Void

extension UIImageView {
    
   
    func setImage(url: URL) {
        
      
        downloadImageWithUrlSession(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    
    
    private func downloadImageWithUrlSession (url: URL, completion: ImageCompletion?) {
        
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                completion?(nil)
                return
            }
            completion?(image)
        }.resume()
    }
}
