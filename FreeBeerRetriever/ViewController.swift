//
//  ViewController.swift
//  FreeBeerRetriever
//
//  Created by jon.hall on 2/10/16.
//  Copyright © 2016 jon.hall. All rights reserved.
//

import UIKit
//import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("Something happened!!")
        
        let myURLString = "https://google.com"
        
        if let myURL = NSURL(string: myURLString) {
            let myHTMLString: NSString?
            do {
                myHTMLString = try NSString(contentsOfURL: myURL, encoding: NSISOLatin1StringEncoding)
            }
            catch {
                print(error)
                myHTMLString = nil
            }
            
            print("HTML : \(myHTMLString)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

