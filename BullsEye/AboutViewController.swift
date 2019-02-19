//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Tony Contreras on 2/14/19.
//  Copyright © 2019 Orbit Networks. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let htmlPath = Bundle.main.path(forResource: "appfile", ofType: "html") {
        let url = URL(fileURLWithPath: htmlPath)
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }

    

}
