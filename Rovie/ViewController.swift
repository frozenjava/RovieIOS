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
        print("-----" + msg)
    }
    
    @IBAction func connectHostButtonAction(sender: UIButton, forEvent event: UIEvent) {
        let hostAddress:String! = self.hostAddressField.text
        var validAddress:Bool! = false
        
        // Verify a valid IPv4 address
        if hostAddress.rangeOfString(self.IP_REGEX, options: .RegularExpressionSearch) == nil {
            self.sendConnectionStatus("Please enter a valid IPv4 address.")
        } else {
            //self.connectionStatusLabel.hidden = true
            validAddress = true
        }
        
        if (validAddress == true) {
            self.hideKeyboard()
            let activitiyViewController = ActivityViewController(message: "Connecting...")
            presentViewController(activitiyViewController, animated: true, completion: nil)
            // Attempt to connect to the robot
            HTTPGet("http://" + hostAddress + ":8080/connect") {
                (data: String, error: String?) -> Void in
                if error != nil {
                    print(error)
                    self.sendConnectionStatus(error!)
                    print("penis")
                    self.dismissViewControllerAnimated(true, completion: {})
                } else {
                    print("data is : \n\n\n")
                    print(data)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    let rovieController = self.storyboard?.instantiateViewControllerWithIdentifier("Controller") as! RovieControllerViewController
                    rovieController.setHostAddress(hostAddress)
                    self.presentViewController(rovieController, animated: true, completion:nil)
                }
            }
            /*if (foundRovie == true) {
                let rovieController = RovieControllerViewController(host: hostAddress)
                self.presentViewController(rovieController, animated: true, completion: {})
            }*/
        }
    }

}

