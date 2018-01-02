//
//  ProfileCell.swift
//  DailyDiary
//
//  Created by sutie on 2017. 12. 17..
//  Copyright © 2017년 sutie. All rights reserved.
//  데이터를 보여주는 역할 (셀 자체는

import UIKit
import SwiftyJSON

// Profile 클래스가 DTO/ model
class Profile {
    var username: String = ""
    var phone: String = ""
    var id: String = ""
    var gender: String = ""
    var location: String = ""
    var email: String = ""
    var cachedImage: UIImage?
    var urlOfImage: String
    
    init(jsonProfile: JSON) {
        username = jsonProfile["results"][0]["login"]["username"].rawString()!
        phone = jsonProfile["results"][0]["phone"].rawString()!
        id = jsonProfile["results"][0]["id"]["value"].rawString()!
        urlOfImage = jsonProfile["results"][0]["picture"]["medium"].rawString()!
        gender = jsonProfile["results"][0]["gender"].rawString()!
        location = jsonProfile["results"][0]["location"]["state"].rawString()!
        email = jsonProfile["results"][0]["email"].rawString()!
        
    }
}


class ProfileCell: UITableViewCell{
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var genderImage: UIImageView!
    
    
    // TableView와 TableViewCell간의 강한 커플링 문제 해결
    func setModel(userInfo: Profile, tag: Int){
        userNameLabel.text = userInfo.username
        phoneLabel.text = userInfo.phone
        deleteButton.tag = tag
        
        // gender에 따른 성별 표시 아이콘 이미지
        if userInfo.gender == "female" {
            let genderIndicatorImage = UIImage(named: "Female")
            genderImage.image = genderIndicatorImage
        } else {
            let genderIndicatorImage = UIImage(named: "Male")
            genderImage.image = genderIndicatorImage
        }
        
        //이미지 url를 옵셔널 바인딩으로 cell에 이미지 띄운다
        if let url = URL(string: userInfo.urlOfImage){
            //url에서 가져온 데이터!!
            if let picData = try? Data(contentsOf: url){
                if let image = UIImage(data: picData){
                    let radius: CGFloat = 50.0
                    let size = CGSize(width: 100.0, height: 100.0)
                    
                    let aspectScaledToFitImage = image.af_imageAspectScaled(toFit: size)
                    let roundedImage = aspectScaledToFitImage.af_imageRounded(withCornerRadius: radius)
                    
                    pictureView.image = roundedImage.af_imageRoundedIntoCircle()
                    userInfo.cachedImage = pictureView.image    //프로필 이미지 캐싱
                    
                }
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}


