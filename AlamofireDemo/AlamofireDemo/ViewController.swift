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
import SWXMLHash
import CocoaSecurity
import CryptoKit

//import PassKit

extension String {
    var md5_hex: String { return CocoaSecurity.md5(self).hex }
    var md5_hexLower: String { return CocoaSecurity.md5(self).hexLower }
    var sha1_hex: String { return CocoaSecurity.sha1(self).hex }
    var md5_base64: String { return CocoaSecurity.md5(self).base64 }
}

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        abcd()
    }

    func abcd() {
        
        let md5string = "13818740118".md5_base64.md5_base64.md5_base64
        let abc = "123213".data(using: .utf8)?.digest(using: .md5).base64EncodedString()

        print("md5: \(md5string)", abc)
//        
//        let xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\"?><DLM.LoginUser><PARAMS><PARAM pname=\"Result\" pval=\"1\" /><PARAM pname=\"ResultInfo\" pval=\"登录成功\" /></PARAMS><PARAMS><PARAM pname=\"PushInfoNum\" pval=\"0\" /></PARAMS></DLM.LoginUser>"
//        let xml = SWXMLHash.parse(xmlString)
//        let resultInfo = try? xml["DLM.LoginUser"]["PARAMS"][0]["PARAM"].withAttr("pname", "ResultInfo").element?.attribute(by: "pval")?.text
//        
//        print( resultInfo!! )//
//        
    
        //下载PASS
        download("http://www.bz55.com/uploads/allimg/150203/139-150203135309.jpg") { (_, _) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("123.jpg")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }.downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
        }.responseData { [unowned self] response in
            
            if let data = response.result.value {
                var error: NSError? = nil
                let pass = PKPass(data: data, error: &error)

                if error == nil {
                    let addPassesController = PKAddPassesViewController(pass: pass)
                    //addPassesController.delegate = self
                    self.present(addPassesController, animated: true, completion: nil)
                }

                //                let image = UIImage(data: data)
                //                let imageView = UIImageView(image: image)
                //                self.view.addSubview(imageView)
            }
            
        }
    
        Alamofire.request("http://pic1.5442.com/2013/0709/05/01.jpg", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate(contentType: ["image/*"]).validate(statusCode: [200]).responseData { (response) in
                        print("\n\nresponse.request")
                        print(response.request)  // original URL request
                        print("\n\nresponse.response")
                        print(response.response) // HTTP URL response
                        print("\n\nresponse.data")
                        print(response.data)     // server data
                        print("\n\nresponse.result")
                        print(response.result)   // result of response serialization

            switch response.result {
            case .success(let value):
                print("\n\nresponse.result.value")
                let image = UIImage(data: value)
                let imageview = UIImageView(image: image)
                self.view.addSubview(imageview)
            case .failure(let error):
                print("\n\nresponse.result.error", error.localizedDescription)
                switch error as! AFError {
                case .responseValidationFailed(reason: let reason):
                    switch reason {
                    case .unacceptableStatusCode(code: let code):
                        print("unacceptable status code is \(code)")
                    default: break
                    }
                default: break
                }
            }

        }.
    }
        
        

//        request("http://hs-app.oss-cn-hangzhou.aliyuncs.com/hsApp%2Fselfie?OSSAccessKeyId=LTAIaFN7dQaExC1h&Expires=1477382047&Signature=Ht9qPLKuaELvY16o6QUF9zd5nvA%3D", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData { response in
//            print("\n\nresponse.request")
//            print(response.request)  // original URL request
//            print("\n\nresponse.response")
//            print(response.response) // HTTP URL response
//            print("\n\nallHTTPHeaderFields")
//            print(response.request?.allHTTPHeaderFields)
//            print("\n\nresponse.data")
//            print(response.data)     // server data
//            print("\n\nresponse.result")
//            print(response.result)   // result of response serialization
//            
//            
//            switch response.result {
//            case .failure(let error):
//                print(error)
//            case .success:
//                let image = UIImage(data: response.data!)
//                let imageview = UIImageView(image: image)
//                self.view.addSubview(imageview)
//            }
//        }

        
    //获取外部IP地址
//        let ipURL = URL(string: "http://pv.sohu.com/cityjson?ie=utf-8")!
//        let ip = try? String(contentsOf: ipURL, encoding: String.Encoding.utf8)
//        print(ip)
//        
   
    
    //获取内部IP地址
//    func getWiFiAddress() -> String? {
//        var address : String?
//        // Get list of all interfaces on the local machine:
//        var ifaddr : UnsafeMutablePointer<ifaddrs>?
//        guard getifaddrs(&ifaddr) == 0 else { return nil }
//        guard let firstAddr = ifaddr else { return nil }
//        // For each interface ...
//        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
//            let interface = ifptr.pointee
//            // Check for IPv4 or IPv6 interface:
//            let addrFamily = interface.ifa_addr.pointee.sa_family
//            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//                
//                // Check interface name:
//                let name = String(cString: interface.ifa_name)
//                if  name == "en0" {
//                    
//                    // Convert interface address to a human readable string:
//                    var addr = interface.ifa_addr.pointee
//                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),
//                                &hostname, socklen_t(hostname.count),
//                                nil, socklen_t(0), NI_NUMERICHOST)
//                    address = String(cString: hostname)
//                }
//            }
//        }
//        freeifaddrs(ifaddr)
//        return address
//    }
    


}

