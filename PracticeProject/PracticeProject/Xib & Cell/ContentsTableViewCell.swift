//
//  ContentsTableViewCell.swift
//  PracticeProject
//
//  Created by Prasad Nesargi on 15/12/17.
//  Copyright © 2017 bitjini. All rights reserved.
//

import UIKit

class ContentsTableViewCell: UITableViewCell {
 let defaults = UserDefaults.standard
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var showBtn: UIButton!
    let webView = WebViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    @IBAction func showPage(_ sender: Any) {
//        //print(showBtn.tag)
//        let value = links[showBtn.tag]
//        print(value)
//        defaults.set(value, forKey: "pagePath")
//        webView.loadUrl()
//
//    }
}
