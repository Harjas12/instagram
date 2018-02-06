//
//  PostDetailViewController.swift
//  instagram
//
//  Created by Harjas Monga on 2/3/18.
//  Copyright © 2018 Harjas Monga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostDetailViewController: UIViewController {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var instagramPost: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.file = instagramPost["media"] as? PFFile
        postImageView.loadInBackground()
        authorLabel.text = "By " + ((instagramPost["author"] as? PFUser)?.username)!
        captionLabel.text = instagramPost["caption"] as? String
        let date = instagramPost.createdAt!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let dateString = dateFormatter.string(from: date)
        dateLabel.text = dateString
    }
    @IBAction func swippedRightOnScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
