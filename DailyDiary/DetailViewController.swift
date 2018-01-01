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
        profileImage.image = model?.cachedImage
    }
}
