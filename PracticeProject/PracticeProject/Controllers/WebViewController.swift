//
//  WebViewController.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 18/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    let defaults = UserDefaults.standard
    var links = ["http://demo.technowebmart.com/pandeyji_mob_app/appointment.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/doctors.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/services.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/locations.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/contact.html"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadUrl()
        
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.isHidden = true
    }
    
    func webViewDidStartLoad(_ : UIWebView) {
        activityIndicator.startAnimating()
    }
    
    
    func loadUrl() {
        //Using Cell
        let ind = defaults.string(forKey: "index")
        webView.loadRequest(URLRequest(url: URL(string: ind!)!))
        print(ind!)
        
        //Using Button
//        let pageAddr = defaults.string(forKey: "pagePath")
//        print(pageAddr!)
//        webView.loadRequest(URLRequest(url: URL(string: pageAddr!)!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
