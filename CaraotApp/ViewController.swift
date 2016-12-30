//
//  ViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 10/11/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit
import RESideMenu

class ViewController: RESideMenu {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func segue(tag: Int) {
        
        switch tag {
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
    
}

