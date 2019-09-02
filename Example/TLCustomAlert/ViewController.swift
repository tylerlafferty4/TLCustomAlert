//
//  ViewController.swift
//  TLCustomAlert
//
//  Created by tylerlafferty4@gmail.com on 09/02/2019.
//  Copyright (c) 2019 tylerlafferty4@gmail.com. All rights reserved.
//

import UIKit
import TLCustomAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = TLCustomAlertView()
        let okayAction = TLCustomAlertAction(title: "Okay") {
            // Called when okay button is tapped
        }
        let cancelAction = TLCustomAlertAction(title: "Cancel") {
            // Called when cancel button is tapped
        }
        alert.showAlertView(superview: view, title: "CustomApp", text: "This is a custom alert message", confirmAction: okayAction, cancelAction: cancelAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

