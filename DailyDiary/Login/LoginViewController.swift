//
//  LoginViewController.swift
//  DailyDiary
//
//  Created by sutie on 2017. 11. 26..
//  Copyright © 2017년 sutie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedLoginButton(_ sender: Any) {
        let id = idTextField.text!
        let password = passwordTextField.text!
        
        if id == "sutie", password == "1234" {
            print("login success")
        } else {
            print("login fail")
        }
        
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
