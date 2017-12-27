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
    var location: String = ""
    
    init(jsonProfile: JSON) {
        username = jsonProfile["results"][0]["login"]["username"].rawString()!
        phone = jsonProfile["results"][0]["phone"].rawString()!
        id = jsonProfile["results"][0]["id"]["value"].rawString()!
        picture = jsonProfile["results"][0]["picture"]["medium"].rawString()!
        gender = jsonProfile["results"][0]["gender"].rawString()!
        location = jsonProfile["results"][0]["location"]["state"].rawString()!
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
    
 
    // TableView와 TableViewCell간의 강한 커플링 문제 해결
    func setModel(tbView: UITableView, userInfo: ProfileList){
        userNameLabel.text = userInfo.username
        phoneLabel.text = userInfo.phone
        
        //이미지 url를 옵셔널 바인딩으로 cell에 이미지 띄운다
        if let url = URL(string: userInfo.picture){
            //url에서 가져온 데이터!!
            if let picData = try? Data(contentsOf: url){
                if let image = UIImage(data: picData){
                    let radius: CGFloat = 50.0
                    let size = CGSize(width: 100.0, height: 100.0)
                    
                    let aspectScaledToFitImage = image.af_imageAspectScaled(toFit: size)
                    let roundedImage = aspectScaledToFitImage.af_imageRounded(withCornerRadius: radius)
                    
                    pictureView.image = roundedImage.af_imageRoundedIntoCircle()
                }
            }
        }
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}


