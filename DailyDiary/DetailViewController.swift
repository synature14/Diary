//
//  detailView.swift
//  DailyDiary
//
//  Created by sutie on 2017. 12. 27..
//  Copyright © 2017년 sutie. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var model: Profile?

    func setModel(_ model: Profile) {
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        genderLabel.text = model?.gender
        locationLabel.text = model?.location
    }
}
