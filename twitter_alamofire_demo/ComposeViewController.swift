//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Cameryn Boyd on 7/3/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

protocol ComposeViewControllerDelegate: class {
    func didPostTweet(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tweetButton: UIButton!
    
    weak var delegate: ComposeViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        //self.textView = RSKPlaceholderTextView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 100))
        //self.view.addSubview(self.textView)
        // Do any additional setup after loading the view.
        tweetButton.layer.cornerRadius = 8; // this value vary as per your desire
        tweetButton.clipsToBounds = true;
        
    }

    
    @IBAction func didDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressTweet(_ sender: Any) {
        
        if let tweetText = textView.text {
        
            APIManager.shared.composeTweet(with: tweetText) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.delegate?.didPostTweet(post: tweet)
                        print("THIS IS THE TWEET \(tweet)")
                        self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
