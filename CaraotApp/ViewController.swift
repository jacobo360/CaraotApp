//
//  ViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/11/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import RESideMenu

class ViewController: RESideMenu, RESideMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Design
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_menu_white"), style: .plain, target: self, action: #selector(ViewController.menuTapped))
    }

    func segue(tag: Int) {
        
        switch tag {
        case 1:
            performSegue(withIdentifier: "to_perfil", sender: self)
            break
        case 2:
            performSegue(withIdentifier: "to_buscador", sender: self)
            break
        case 3:
            performSegue(withIdentifier: "to_reportero", sender: self)
            break
        default:
            break
        }
        
    }
    
    func menuTapped() {
        
        self.presentLeftMenuViewController()
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func sideMenu(_ sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
}

