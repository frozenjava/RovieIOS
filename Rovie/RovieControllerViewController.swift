//
//  RovieControllerViewController.swift
//  Rovie
//
//  Created by Joshua Artuso on 11/26/15.
//  Copyright © 2015 codeit. All rights reserved.
//

import Foundation
import UIKit

class RovieControllerViewController: UIViewController {
    
    private var hostAddress:String = ""
    
    init(host: String) {
        self.hostAddress = host
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setHostAddress(host:String) {
        self.hostAddress = host
    }

    private func sendMovementRequest(direction:String) {
        HTTPGet("http://" + self.hostAddress + ":8080/move/" + direction) {
            (data: String, error:String?) -> Void in
            if error != nil {
                print(error)
            } else {
                print(data)
            }
        }
    }
    
    @IBAction func buttonDownAction(sender: UIButton) {
        switch(sender.currentTitle) {
            case "Left Forward"?:
                self.sendMovementRequest("left")
            
            case "Left Backward"?:
                self.sendMovementRequest("left_reverse")
            
            case "Right Forward"?:
                self.sendMovementRequest("right")
            
            case "Right Backward"?:
                self.sendMovementRequest("right_reverse")
            
            default:
                print("unkown title")
        }
    }
    
    @IBAction func buttonUpAction(sender: UIButton) {
        self.sendMovementRequest("stop")
    }
    
    
}