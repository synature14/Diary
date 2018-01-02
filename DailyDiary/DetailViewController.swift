//
//  detailView.swift
//  DailyDiary
//
//  Created by sutie on 2017. 12. 27..
//  Copyright © 2017년 sutie. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var model: Profile?

    func setModel(_ model: Profile) {
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        IDLabel.text = model?.id
        phoneLabel.text = model?.phone
        genderLabel.text = model?.gender
        emailLabel.text = model?.email
        
        if genderLabel.text == "female" {
            genderLabel.textColor = UIColor(red: 0.7, green: 0.0, blue: 0.1, alpha: 1)
        } else {
            genderLabel.textColor = UIColor(red: 0.1, green: 0.2, blue: 0.7, alpha: 1)
        }
        
        
        if let cache = model?.cachedImage {
            profileImage.image = cache
        } //캐시되지 않았다면, url주소로부터 이미지 불러온다.
        else {
            if let urlString = model?.urlOfImage {
                if let url = URL(string: urlString){
                    if let picData = try? Data(contentsOf: url){
                        if let image = UIImage(data: picData){
                            let radius: CGFloat = 50.0
                            let size = CGSize(width: 100.0, height: 100.0)
                            
                            let aspectScaledToFitImage = image.af_imageAspectScaled(toFit: size)
                            let roundedImage = aspectScaledToFitImage.af_imageRounded(withCornerRadius: radius)
                            
                            profileImage.image = roundedImage.af_imageRoundedIntoCircle()
                        }
                    }
                }
            }
        } //else
    } //setupViews()
}
