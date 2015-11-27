//
//  Communications.swift
//  Rovie
//
//  Created by Joshua Artuso on 11/26/15.
//  Copyright © 2015 codeit. All rights reserved.
//
//  I am trying to learn how to properly do HTTP requests in swift
//  Credits: https://medium.com/swift-programming/http-in-swift-693b3a7bf086#.uq86cgah0
//

import Foundation

func HTTPSendRequest(request:NSMutableURLRequest, callback: (String, String?) -> Void) {
    
    let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
        data, response, error in
        if error != nil {
            callback("", (error!.localizedDescription) as String)
        } else {
            callback(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String,nil)
        }
    })
    
    task.resume()
    
}

func HTTPGet(url:String, callback: (String, String?) -> Void) {
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    HTTPSendRequest(request, callback: callback)
}