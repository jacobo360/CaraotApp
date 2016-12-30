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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segueFromSide(_ sender: UIButton) {
    
        let parent = self.parent as! ViewController
        parent.segue(tag: sender.tag)
    
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
