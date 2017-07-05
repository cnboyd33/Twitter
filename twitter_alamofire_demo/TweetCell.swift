//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func onRetweet(_ sender: Any) {
        if retweetButton.isSelected {
            retweetButton.isSelected = true
        } else {
            retweetButton.isSelected = false
        }
    }
    @IBAction func onFavorite(_ sender: Any) {
        if favButton.isSelected {
            favButton.isSelected = true
        } else {
            favButton.isSelected = false
        }
        
    }
    
    
    var tweet: Tweet! {
        didSet {
            profileImageView.af_setImage(withURL: URL(string: tweet.user.profileImage)!)
            tweetTextView.text = tweet.text
            authorLabel.text = tweet.user.name
            dateLabel.text = tweet.createdAtString
            screenNameLabel.text = "@" + tweet.user.screenName!
            favCountLabel.text = String(describing: tweet.favoriteCount)
            retweetCountLabel.text = String(tweet.retweetCount)
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
