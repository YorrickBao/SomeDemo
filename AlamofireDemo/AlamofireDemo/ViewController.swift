//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by 鲍的Mac on 2016/10/17.
//  Copyright © 2016年 YorrickBao. All rights reserved.
//
//"https://httpbin.org/get"

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
//    var json: JSON? {didSet{printJSON()}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        abcd()
    }

    func abcd() {
//        //http://pic1.5442.com/2013/0709/05/01.jpg
//        request("http://pic1.5442.com/2013/0709/05/01.jpg", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(contentType: ["image/*"]).validate(statusCode: [200]).responseData { (response) in
//                        print("\n\nresponse.request")
//                        print(response.request)  // original URL request
//                        print("\n\nresponse.response")
//                        print(response.response) // HTTP URL response
//                        print("\n\nresponse.data")
//                        print(response.data)     // server data
//                        print("\n\nresponse.result")
//                        print(response.result)   // result of response serialization
//
//            switch response.result {
//            case .success(let value):
//                print("\n\nresponse.result.value")
//                let image = UIImage(data: value)
//                let imageview = UIImageView(image: image)
//                self.view.addSubview(imageview)
//            case .failure(let error):
//                print("\n\nresponse.result.error", error.localizedDescription)
//                switch error as! AFError {
//                case .responseValidationFailed(reason: let reason):
//                    switch reason {
//                    case .unacceptableStatusCode(code: let code):
//                        print("unacceptable status code is \(code)")
//                    default: break
//                    }
//                default: break
//                }
//            }
//
//        }
//
//        if let url = URL(string: "http://www.fj.xinhuanet.com/zt/zggnr/2014-03-28/119993707_31n.jpg") {
//            if let data = NSData(contentsOf: url) as? Data {
//                if let image = UIImage(data: data) {
//                    let imageview = UIImageView(image: image)
//                    view.addSubview(imageview)
//                } else {
//                    print("nil image")
//                }
//            } else {
//                print("nil data")
//            }
//        } else {
//            print("nil url")
//        }
        
        

//        do {
//            let mData = try Data(contentsOf: URL(string: "http://www.fj.xinhuanet.com/zt/zggnr/2014-03-28/119993707_31n.jpg")!)
//            let image = UIImage(data: mData)
//            let imageview = UIImageView(image: image)
//            view.addSubview(imageview)
//        } catch let error {
//            print("error!!!!!\(error.localizedDescription)")
//        }
        //OSS LTAIaFN7dQaExC1h:8iiTLOwxcIcfYjBomMCubqSbLbU=
        //OSS LTAIaFN7dQaExC1h:sfztK68MJuYKOq4FW8W+CT3GPTQ=
        //OSS LTAIaFN7dQaExC1h:JImX6q/9YfIRjx8mZfkTrpZkfx8=

        request("http://hs-app.oss-cn-hangzhou.aliyuncs.com/hsApp%2Fselfie?OSSAccessKeyId=LTAIaFN7dQaExC1h&Expires=1477382047&Signature=Ht9qPLKuaELvY16o6QUF9zd5nvA%3D", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
            print("\n\nresponse.request")
            print(response.request)  // original URL request
            print("\n\nresponse.response")
            print(response.response) // HTTP URL response
            print("\n\nallHTTPHeaderFields")
            print(response.request?.allHTTPHeaderFields)
            print("\n\nresponse.data")
            print(response.data)     // server data
            print("\n\nresponse.result")
            print(response.result)   // result of response serialization
            
            
            switch response.result {
            case .failure(let error):
                print(error)
            case .success:
                let image = UIImage(data: response.data!)
                let imageview = UIImageView(image: image)
                self.view.addSubview(imageview)
            }
        }
    }
    
//    func printJSON() {
//        guard let json = json else {return}
//        let origin = json["origin"].stringValue
//        print("origin:  ",origin)
//    }

}

