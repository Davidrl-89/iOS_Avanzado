//
//  LoginViewController.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import UIKit

protocol LoginDelegate {
    func dismiss()
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    var delegate: LoginDelegate?
    
    init(delegate: LoginDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
#if DEBUG
        
        username?.text = "drobles988@gmail.com"
        password?.text = "drl2810"
        
#endif
        
        viewModel.onError = { [weak self] message in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
            }
            print(message)
        }
        
        viewModel.onLogin = { [weak self] in
            DispatchQueue.main.async {
                self?.loginButton.isEnabled = true
                self?.delegate?.dismiss()
                self?.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func loginPress(_ sender: Any) {
        guard let user = username.text,
              let password = password.text else {
            return
        }
        if user.isEmpty || password.isEmpty {
            return
        }
        
        viewModel.login(with: user, password: password)
        
    }
}
