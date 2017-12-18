       //
//  ViewController.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 14/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnLogin: UIView!
    @IBOutlet weak var btnLogout: UIView!
    @IBOutlet weak var btnRegister: UIView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var openLink: UIButton!
    
    let defaults = UserDefaults.standard
    var buttonAction = ContentsTableViewCell()
    
    var menuVC : MenuTableViewController!
    var imageArray = [UIImage]()
    var contents = [#imageLiteral(resourceName: "icons8-Planner-26"),#imageLiteral(resourceName: "icons8-Stethoscope-64"),#imageLiteral(resourceName: "icons8-Ambulance-26"),#imageLiteral(resourceName: "icons8-Marker Filled-50"),#imageLiteral(resourceName: "icons8-Phone-26")]
    var links = ["http://demo.technowebmart.com/pandeyji_mob_app/appointment.html","http://demo.technowebmart.com/pandeyji_mob_app/doctors.html","http://demo.technowebmart.com/pandeyji_mob_app/services.html","http://demo.technowebmart.com/pandeyji_mob_app/locations.html","http://demo.technowebmart.com/pandeyji_mob_app/contact.html"]
    var contentsText = ["Enquiry","Charted Accountants","Services","Locations","Contact"]
    
    @IBAction func openLink(_ sender: Any) {
       // UIApplication.shared.openURL(URL(string: "http://www.stackoverflow.com")!)
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuVC = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        navigationBar()
        scrollView()
        openLink.isHidden = true
    }
    
    func navigationBar() {
        btnLogout.isHidden = true
        menuBtn.tintColor = UIColor.white
        navBar.backgroundColor = UIColor(red: 67/255.0, green: 80/255.0, blue: 175/255.0, alpha: 1.0)
    }
    
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
        scrollViewSwipe()
    }
    
    func scrollViewSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        btnLogin.isHidden = true
        btnRegister.isHidden = true
        btnLogout.isHidden = false
        let alert = UIAlertController(title: "Message", message: "Login Successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnLogout(_ sender: Any) {
        btnLogin.isHidden = false
        btnRegister.isHidden = false
        btnLogout.isHidden = true
        let alert = UIAlertController(title: "Message", message: "Logout Successful", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    func closeOnSwipe() {
        if AppDelegate.menu_bool{
            //showmenu
            //showMenu()
        } else {
            closeMenu()
        }
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        if AppDelegate.menu_bool{
            //showmenu
            showMenu()
        } else {
            closeMenu()
        }
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5) { ()->Void in
        self.menuVC.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.menuVC.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.addChildViewController(self.menuVC)
            self.view.addSubview(self.menuVC.view)
        AppDelegate.menu_bool = false
        }
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.5, animations: { ()->Void in
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menuVC.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsText.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Using Button
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsTableViewCell", for: indexPath)as! ContentsTableViewCell
//            cell.showBtn.setImage(contents[indexPath.row], for: .normal)
//            cell.showBtn.setTitle(contentsText[indexPath.row], for: .normal)
//        cell.showBtn.tag = indexPath.row

        //Using Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentsTableViewCell", for: indexPath) as! ContentsTableViewCell
        cell.content.text = contentsText[indexPath.row]
        cell.showBtn.isHidden = true
        cell.icon.image = contents[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defaults.set(links[indexPath.row], forKey: "index")
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

//     For making scrollview a tableview header
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let sview = UIScrollView()
//
//        imageArray = [#imageLiteral(resourceName: "tax2"),#imageLiteral(resourceName: "tax4"),#imageLiteral(resourceName: "tax5"),#imageLiteral(resourceName: "tax6")]
//        for i in 0..<imageArray.count {
//            let imageView = UIImageView()
//            imageView.image = imageArray[i]
//
//            // imageView.contentMode = .scaleAspectFill
//            let xPosition = sview.frame.width * CGFloat(i)
//            imageView.frame = CGRect(x: xPosition, y: 0, width: 300, height: 150)
//            sview.contentSize.width = sview.frame.width * CGFloat(i + 1)
//            sview.addSubview(imageView)
//        }
//      //  scrollViewSwipe()
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
//        swipeRight.direction = UISwipeGestureRecognizerDirection.right
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
//        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//        self.view.addGestureRecognizer(swipeRight)
//        self.view.addGestureRecognizer(swipeLeft)
//
//        return sview
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 150
//    }
    
    
}

