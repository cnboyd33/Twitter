//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation
import AlamofireImage


class User {
    
    var name: String?
    var screenName: String?
    private static var _current: User?
    var dictionary: [String: Any]?
    var profileImage: String
    var bannerURL: String
    var following: Int
    var followers: Int
    
  
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        profileImage = dictionary["profile_image_url_https"] as! String
        bannerURL = dictionary["profile_banner_url"] as! String
        followers = dictionary["followers_count"] as! Int
        following = dictionary["friends_count"] as! Int
    
    }
    
    
}
