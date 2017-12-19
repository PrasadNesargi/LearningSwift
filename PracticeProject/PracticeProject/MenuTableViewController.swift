//
//  MenuTableViewController.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 14/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let defaults = UserDefaults.standard
    var vcInstance = ViewController()
    var menuTitleArray = ["Home","Team","Enquiry","Departments","Contact"]
    
    var menuLinks = ["http://demo.technowebmart.com/pandeyji_mob_app/main.html","http://demo.technowebmart.com/pandeyji_mob_app/doctors.html","http://demo.technowebmart.com/pandeyji_mob_app/appointment.html","http://demo.technowebmart.com/pandeyji_mob_app/departments.html","http://demo.technowebmart.com/pandeyji_mob_app/contact.html"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableViewCell
        cell.menuTitle.text = menuTitleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defaults.set(menuLinks[indexPath.row], forKey: "index")
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
