//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import DateToolsSwift


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
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var replyTextConstraint: NSLayoutConstraint!
    
    @IBAction func onRetweet(_ sender: Any) {
        if retweetButton.isSelected {
            retweetButton.isSelected = false
            tweet.retweeted = true
            tweet.retweetCount -= 1
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }

            refreshData()
            
        } else {
            retweetButton.isSelected = true
            tweet.retweeted = false
            tweet.retweetCount += 1
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }

            refreshData()
        }
    }
    @IBAction func onFavorite(_ sender: Any) {
        if favButton.isSelected {
            favButton.isSelected = false
            tweet.favorited = true
            tweet.favoriteCount -= 1
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            refreshData()
        } else {
            favButton.isSelected = true
            tweet.favorited = false
            tweet.favoriteCount += 1
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }

            refreshData()
        }
    }
    
    func refreshData() {
        profileImageView.af_setImage(withURL: URL(string: tweet.user.profileImage)!)
        tweetTextView.text = tweet.text
        authorLabel.text = tweet.user.name
        dateLabel.text = tweet.createdAtString
        screenNameLabel.text = "@" + tweet.user.screenName!
        favCountLabel.text = String(tweet.favoriteCount)
        retweetCountLabel.text = String(tweet.retweetCount)
        
        // Make profile pic circular
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true

    }
    
    var tweet: Tweet! {
        didSet {
            profileImageView.af_setImage(withURL: URL(string: tweet.user.profileImage)!)
            tweetTextView.text = tweet.text
            authorLabel.text = tweet.user.name
            dateLabel.text = tweet.createdAtString
            screenNameLabel.text = "@" + tweet.user.screenName!
            favCountLabel.text = String(tweet.favoriteCount)
            retweetCountLabel.text = String(tweet.retweetCount)
            
            // Make profile pic circular
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.borderColor = UIColor.lightGray.cgColor
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true
            
            if let url = tweet.displayURL {
                mediaImageView.isHidden = false
                mediaImageView.af_setImage(withURL: url)
                replyTextConstraint.constant = 400
                
            } else {
                mediaImageView.isHidden = true
                replyTextConstraint.constant = 4
                
            }
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
