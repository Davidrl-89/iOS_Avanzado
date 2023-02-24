//
//  LoginViewModel.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import UIKit

final class LoginViewModel {
    
    private var networkModel: NetworkModel
    var onError: ((String) -> Void)?
    var onLogin: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         onError: ((String) -> Void)? = nil,
         onLogin: (() -> Void)? = nil)
    {
        self.networkModel = networkModel
        self.onError = onError
        self.onLogin = onLogin
    }
    
    func login(with user: String, password: String) {
        networkModel.login(user: user, password: password) { [weak self] token, error in
            if let error = error {
                self?.onError?(error.localizedDescription)
            }
            
            guard let token = token, !token.isEmpty else {
                self?.onError?("Wrong token")
                return
            }
            
            KeychainManager.shared.saveData(key: "KCToken", value: token)
            self?.onLogin?()
        }
    }
}
