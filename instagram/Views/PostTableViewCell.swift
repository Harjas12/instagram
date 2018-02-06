//
//  PostTableViewCell.swift
//  instagram
//
//  Created by Harjas Monga on 2/3/18.
//  Copyright © 2018 Harjas Monga. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var instagramPost: PFObject! {
        didSet {
            self.postImageView.file = instagramPost["media"] as? PFFile
            self.postImageView.loadInBackground()
            self.authorLabel.text = (instagramPost["author"] as? PFUser)?.username
            self.captionLabel.text = instagramPost["caption"] as? String
        }
    }
}
