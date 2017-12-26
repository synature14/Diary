//
//  LoginViewController.swift
//  DailyDiary
//
//  Created by sutie on 2017. 11. 26..
//  Copyright © 2017년 sutie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class LoginViewController: UIViewController {
    
    //json파일을 담을 배열
    var items: [ProfileList] = []
    
    @IBOutlet weak var tableView: UITableView!
    
//    private var selectedIndexPath : IndexPath?
//
    func requestImage(path: String, completionHandler: @escaping (Image) -> Void){
        Alamofire.request("\(path)").responseImage(imageScale: 1.5, inflateResponseImage: false, completionHandler: {response in
            guard let image = response.result.value else{
                print(response.result)
                return
            }
            DispatchQueue.main.async {
                completionHandler(image)
            }
        })
    }
////
//    func parseImage(url: String) -> UIImage {
//        Alamofire.request("\(url)").responseImage(imageScale: 1.5, inflateResponseImage: false, completionHandler: { response in
//            debugPrint(response)
//
//            debugPrint(response.result)
//
//            if let image: UIImage = response.result.value{
//                print("image downloaded : \(image)")
//
//            }
//            DispatchQueue.main.async {
//                completionHandler(image)
//            }
//        })
//
//
//    }

    
    @IBAction func addButtonTapped(_ sender: Any) {
        Alamofire.request("https://randomuser.me/api/", method: .get)
            .validate().responseJSON(completionHandler: {
                ///// weak self : viewController를 참조하여도 ARC 카운트 1 증가시키지 않겠다!
                [weak self] jsonProfile in
                
                switch jsonProfile.result{
                    
                case .success(let value):
                    let json = JSON(value)
                    let p = ProfileList(jsonProfile: json)
                    self!.items.append(p)
                    //                    let indexPath = IndexPath(row: self!.items.count - 1, section: 0)
                    
                    print("case success")
                    
                    
                    // 코드 -> 쓰레드로 연결을 큐 방식으로!
                    // 쓰레드가 Queue(빨대)에 실행시킬 코드(물컵)를 넣는다
                    // 왜 이 코드블럭을 UI쓰레드가 아니라 백그라운드 쓰레드로 넘기는가? main에서 쓰레드 부하를 줄이기 위해!
                    DispatchQueue.main.async {
                        self!.tableView.reloadData()
                    }
                    //                    self!.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
                    
                    print(json)
                    
                case .failure(let error):
                    print(error)
                }
            })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()  {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


//extension LoginViewController: UITableViewDelegate  {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndexPath = indexPath
//    }
//}

extension LoginViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // 커플링 발생. 클래스와 클래스가 굉장히 강하게 결합되어있다. TableViewCell이 cell의 타입이 무엇인지 정확히 알고 있고 cell의 프로퍼티, 어떤 데이터가 들어가 있는지 너무 정확하게 알고있다. --> ViewCell이 여러개라면? 하나하나 다 추가해줘야 한다. 코드가 너무 길어진다.
        // 클래스와 클래스 사이는 '추상화'를 통해서 데이터가 오고 가야한다. --> 프로토콜을 하나 만들어서 싱위클래스 상속받게 만들어서 다른 외부 클래스는 프로토콜을 이용해서만 데이터 접근하게 만든다!
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell") as! TableViewCell
        cell.userNameLabel.text = items[indexPath.row].username
        cell.phoneLabel.text = items[indexPath.row].phone
        
        //이미지 url
        let url = URL(string: items[indexPath.row].picture)
        //url에서 가져온 데이터!!
        let picData = try! Data(contentsOf: url!)
        let image = UIImage(data: picData)!
        
       // cell.pictureView.af_setImage(withURL: url!)
        
        let radius: CGFloat = 50.0
        let size = CGSize(width: 100.0, height: 100.0)
        
        let aspectScaledToFitImage = image.af_imageAspectScaled(toFit: size)
        let roundedImage = aspectScaledToFitImage.af_imageRounded(withCornerRadius: radius)
        
        cell.pictureView.image = roundedImage.af_imageRoundedIntoCircle()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            items.remove(at: indexPath.row) //데이터 삭제
//            //테이블에서 row 삭제
//            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//        }
//    }

}
