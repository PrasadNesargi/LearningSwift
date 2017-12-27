//
//  WebViewController.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 18/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate, MenuDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var HeaderView: HeaderView!
    var menuVC : MenuTableViewController!
    var VCInstance : ViewController!
    //var mainViewCellDelegate : ContentsTableViewCell!
    
    lazy var loginView : LoginView = {
        let view = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as! LoginView
        view.frame = self.view.bounds
        view.delegate = self
        return view
    }()
    
    lazy var  windowRegister : WindowRegister = {
        let view = Bundle.main.loadNibNamed("WindowRegister", owner: self, options: nil)?.first as! WindowRegister
        view.frame = self.view.bounds
        view.delegate = self
        return view
    }()
    
    let defaults = UserDefaults.standard
    var links = ["http://demo.technowebmart.com/pandeyji_mob_app/appointment.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/doctors.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/services.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/locations.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/contact.html"]
    
    lazy var  mainViewCellDelegate : ContentsTableViewCell = {
        let view = Bundle.main.loadNibNamed("ContentsTableViewCell", owner: self, options: nil)?.first as! ContentsTableViewCell
        view.webPageDelegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //loadUrl()
        onViewDidLoad()
    }
    
    func onViewDidLoad() {
        AppDelegate.menu_bool = true
        let ind = defaults.string(forKey: "pagePath")
        loadPage(link: ind!)
        setDelegates()
        menuViewSwipe()
        HeaderView.btnBack.isHidden = true
        menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
    }
    
    func setDelegates() {
        HeaderView.delegate = self
        HeaderView.headerLoginViewDelegate = self
        mainViewCellDelegate.webPageDelegate = self
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) { activityIndicator.isHidden = true   }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) { activityIndicator.isHidden = true }
    
    func webViewDidStartLoad(_ : UIWebView) { activityIndicator.startAnimating() }
    
    func sample() { print("hello  tret") }
    
    func loadUrl() {
        let ind = defaults.string(forKey: "index")
        webView.loadRequest(URLRequest(url: URL(string: ind!)!))
    }
    
    func loadPage(link: String) { webView.loadRequest(URLRequest(url: URL(string: link)!)) }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5) { ()->Void in
            self.menuVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menuVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.addChildViewController(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.menu_bool = false
        }
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.5, animations: { ()->Void in
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menuVC.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }
    
    //Sidemenu handling gesture
    func menuViewSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissView))
        //        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func respondToGesture(gesture : UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("Right Swipe")
            showMenu()
        case UISwipeGestureRecognizerDirection.left:
            print("Left Swipe")
            closeMenu()
        default:
            break
        }
    }
}

extension WebViewController: PopToPreviousDelegate {
    func popUsingDelegate() { self.navigationController?.popViewController(animated: true) }
}

extension WebViewController: WebPageDelegate {
    func navigateToWebPage(message: String) { webView.loadRequest(URLRequest(url: URL(string: message)!)) }
}

extension WebViewController: HeaderLoginBtnDelegate, LoginViewDelegate, WindowRegisterDelegate {
    func openRegisterView() {
        UIView.animate(withDuration: 0.5) { ()->Void in
            self.windowRegister.tag = 100
            self.view.addSubview(self.windowRegister)
        }
    }
    
    func closeRegisterView() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        } else { print("No!") }
    }
    
    func openLoginView() {
        self.loginView.tag = 101
        UIView.animate(withDuration: 0.5) { ()->Void in
            self.view.addSubview(self.loginView)
        }
    }
    
    func closeLoginView() {
        if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
        } else { print("No!") }
    }
}


    
 
    


