//
//  StartScreenViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-29.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {

  @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.layer.borderWidth = 1
        startButton.layer.cornerRadius = 6
        startButton.layer.borderColor = startButton.tintColor.cgColor
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
