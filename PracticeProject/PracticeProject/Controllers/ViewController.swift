//  ViewController.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 14/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit

protocol LoadWebPageFromVC {
    func loadPageFromVC()
}
class ViewController: UIViewController, HeaderViewDelegate, MenuDelegate {
    
   //outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLogin: UIView!
    @IBOutlet weak var btnLogout: UIView!
    @IBOutlet weak var btnRegister: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    
    //Instance of custom navigation bar
    var headerView = HeaderView()
    
    //Creating instance of register view
    //var windowRegister = WindowRegister()
    lazy var  windowRegister : WindowRegister = {
        let view = Bundle.main.loadNibNamed("WindowRegister", owner: self, options: nil)?.first as! WindowRegister
        view.frame = self.view.bounds
        view.delegate = self 
        return view
    }()
    
    //Creating a instance of login view
    lazy var loginView : LoginView = {
        let view = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as! LoginView
        view.frame = self.view.bounds
        view.delegate = self
        return view
    }()
    
    let defaults = UserDefaults.standard
    var pageButtonAction = ContentsTableViewCell()
    var menuVC : MenuTableViewController!
    var imageArray = [UIImage]()
    var contents = [#imageLiteral(resourceName: "icons8-Planner-26"),#imageLiteral(resourceName: "icons8-stethoscope-24"),#imageLiteral(resourceName: "icons8-Ambulance-26"),#imageLiteral(resourceName: "icons8-marker-24"),#imageLiteral(resourceName: "icons8-Phone-26")]
    var webPageDelegate : LoadWebPageFromVC?
    
    var links = ["http://demo.technowebmart.com/pandeyji_mob_app/appointment.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/doctors.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/services.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/locations.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/contact.html"]
    
    var contentsText = ["Enquiry","Charted Accountants","Services","Locations","Contact"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        onViewDidLoad()
    }
    
    func onViewDidLoad() {
        menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        navigationBar()
        scrollView()
        menuViewSwipe()
        menuVC.menuDelegate = self
    }
    
    //Custom Navigation Bar functions
    func navigationBar() {
        showNavbar(loginButton: false, registerButton: false, logoutButton: true)
        menuBtn.tintColor = UIColor.white
        navBar.backgroundColor = UIColor(red: 67/255.0, green: 80/255.0, blue: 175/255.0, alpha: 1.0)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        self.loginView.tag = 101
        UIView.animate(withDuration: 0.5) { ()->Void in
            self.view.addSubview(self.loginView)
        }
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        showNavbar(loginButton: false, registerButton: false, logoutButton: true)
        alertMessage(message: "Logout Success")
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        UIView.animate(withDuration: 0.5) { ()->Void in
            self.windowRegister.tag = 100
            self.view.addSubview(self.windowRegister)
        }
    }
    
    func showNavbar(loginButton: Bool,registerButton: Bool,logoutButton: Bool) {
        btnLogin.isHidden = loginButton
        btnRegister.isHidden = registerButton
        btnLogout.isHidden = logoutButton
    }
    
    func alertMessage(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Scrollview image load
    func scrollView() {
         imageArray = [#imageLiteral(resourceName: "tax2"),#imageLiteral(resourceName: "tax4"),#imageLiteral(resourceName: "tax5"),#imageLiteral(resourceName: "tax6")]
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            // imageView.contentMode = .scaleAspectFill
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
            mainScrollView.contentSize.width = mainScrollView.frame.width * CGFloat(i + 1)
            mainScrollView.addSubview(imageView)
        }
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
            closeOnSwipe()
        default:
            break
        }
    }
    
    @objc func dismissView() { closeOnSwipe() }
    
    //Hamburger menu button actions
    @IBAction func menuBtnAction(_ sender: Any) {
        if AppDelegate.menu_bool{ showMenu() } else { closeMenu() }
    }
    
    //Testing delegates
    func sample() {
        print("hello  tret")
    }
    
    //will open side menu
    func showMenu() {
        print("hello")
        UIView.animate(withDuration: 0.5) { ()->Void in
            self.menuVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menuVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
            self.addChildViewController(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.menu_bool = false
        }
    }
    
    //will close side menu
    func closeMenu() {
        UIView.animate(withDuration: 0.5, animations: { ()->Void in
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menuVC.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }
    
    func closeOnSwipe() { if AppDelegate.menu_bool == false{ closeMenu() } }
    
}
   
//Seperate extension for tableview portion of View Controller
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsText.count
    }
    
    //Using Button
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsTableViewCell", for: indexPath)as! ContentsTableViewCell
        cell.showBtn.setImage(contents[indexPath.row], for: .normal)
        cell.showBtn.setTitle(contentsText[indexPath.row], for: .normal)
        cell.showBtn.tag = indexPath.row
        cell.webPageDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: WebPageDelegate {
    func navigateToWebPage(message: String) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        //print("ready to call webpage now \(message)")
    }
}

extension ViewController: WindowRegisterDelegate {
    func closeRegisterView() {
        //.self.view.willRemoveSubview(windowRegister)
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        } else { print("No View Available!") }
    }
}

extension ViewController: LoginViewDelegate {
    func closeLoginView() {
        if let viewWithTag = self.view.viewWithTag(101) {
            viewWithTag.removeFromSuperview()
        } else { print("No View Available!") }
    }
}
