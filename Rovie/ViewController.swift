//
//  ViewController.swift
//  Rovie
//
//  Created by Joshua Artuso on 11/3/15.
//  Copyright © 2015 codeit. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var hostAddressField: UITextField!
    @IBOutlet weak var connectHostButton: UIButton!
    
    final let IP_REGEX:String! = "^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\." +
        "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\." +
        "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\." +
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.connectionStatusLabel.hidden = true
        
        // call the hideKeyboard method when the view is tapped
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func hideKeyboard() {
        view.endEditing(true)
    }
    
    /**
     * sendConnectionStatus
     * Set the connectionStatusLabel text to msg
     */
    func sendConnectionStatus(msg:String) {
        self.connectionStatusLabel.hidden = false
        self.connectionStatusLabel.text = msg
    }
    
    @IBAction func connectHostButtonAction(sender: UIButton, forEvent event: UIEvent) {
        let hostAddress:String! = self.hostAddressField.text
        
        // Verify a valid IPv4 address
        if hostAddress.rangeOfString(self.IP_REGEX, options: .RegularExpressionSearch) == nil {
            self.sendConnectionStatus("Please enter a valid IPv4 address.")
        } else {
            self.connectionStatusLabel.hidden = true
        }
        
    }

}

