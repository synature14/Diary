//
//  TableViewCell.swift
//  DailyDiary
//
//  Created by sutie on 2017. 12. 17..
//  Copyright © 2017년 sutie. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileList {
    var username: String = ""
    var phone: String = ""
    var id: String = ""
    var picture: String = ""
    var gender: String = ""
    
    init(jsonProfile: JSON) {
        username = jsonProfile["results"][0]["login"]["username"].rawString()!
        phone = jsonProfile["results"][0]["phone"].rawString()!
        id = jsonProfile["results"][0]["id"]["value"].rawString()!
        picture = jsonProfile["results"][0]["picture"]["medium"].rawString()!
        gender = jsonProfile["results"][0]["gender"].rawString()!
    }
}

//protocol JsonParseAble(profile: ProfileList){
//
//    userNameLabel.text = profile.name
//    phoneLabel.text = profile.phone
//    idLabel.text = profile.id
//
//}



class TableViewCell: UITableViewCell{
    //picture
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
  
    @IBOutlet weak var pictureView: UIImageView!
    
 
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}


