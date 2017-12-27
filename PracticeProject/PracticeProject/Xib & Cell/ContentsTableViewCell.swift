//
//  ContentsTableViewCell.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 15/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit
protocol WebPageDelegate {
    func navigateToWebPage(message: String)
}
class ContentsTableViewCell: UITableViewCell {
    
    let defaults = UserDefaults.standard
    var  webPageDelegate : WebPageDelegate?
    let webView = WebViewController()
    
    @IBOutlet weak var showBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var links = ["http://demo.technowebmart.com/pandeyji_mob_app/appointment.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/doctors.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/services.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/locations.html",
                 "http://demo.technowebmart.com/pandeyji_mob_app/contact.html"]
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func showPage(_ sender: UIButton) {
        //print(sender.tag)
        let value = links[sender.tag]
        defaults.set(value, forKey: "pagePath")
        let ind = defaults.string(forKey: "pagePath")
        webPageDelegate?.navigateToWebPage(message: ind!)
    }
}
