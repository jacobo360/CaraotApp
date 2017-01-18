//
//  SideViewController.swift
//  CaraotApp
//
//  Created by Jacobo Koenig on 12/30/16.
//  Copyright © 2016 Jacobo Koenig. All rights reserved.
//

import UIKit

class SideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func segueFromSide(_ sender: UIButton) {
    
        let parent = self.parent as! ViewController
        parent.segue(tag: sender.tag)
    
    }

}
