//
//  HeroesListViewController.swift
//  iOSAvanzado_Practica
//
//  Created by David Robles Lopez on 21/2/23.
//

import UIKit


class HeroesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = HeroesListViewModel()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LISTA DE HEROES"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
      
        tableView?.register(UINib(nibName: "HeroesTableViewCell", bundle: nil), forCellReuseIdentifier: "viewCell")
        
        
        viewModel.onError = { message in
            DispatchQueue.main.async {
                print(message)
            }
        }
        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.viewDidLoad()
    }
    
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.heroesArray.count
    }
    
    
   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as? HeroesTableViewCell else {
           
            return UITableViewCell()
        }
        
       
        cell.setHero(model: viewModel.heroesArray[indexPath.row])
       
        return cell
    }
    
    

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
                
                let nextVC = DetailViewController()
               
                let hero = viewModel.heroesArray[indexPath.row]
                nextVC.set(model: hero)
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
    @IBAction func logoutTapped(_ sender: Any) {
        KeychainManager.shared.deleteData(key: "KCToken")
        navigationController?.setViewControllers([LoginViewController()], animated: false)
        self.navigationController?.popToRootViewController(animated: true)
    }
    }
    
    
   


