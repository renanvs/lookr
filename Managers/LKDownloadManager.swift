//
//  LKDownloadManager.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

//class LKDownloadRequestModel:NSObject{
//    var url : NSString!
//    var identifierStr : String?
//    
//    init(identifierStr : String, url : String) {
//        self.identifierStr = identifierStr
//        self.url = url
//    }
//}
//
//class LKDownloadResponseModel:NSObject{
//    var url : NSString!
//    var identifierStr : String?
//    
//    init(identifierStr : String, url : String) {
//        self.identifierStr = identifierStr
//        self.url = url
//    }
//}


class LKDownloadManager: NSObject {
    
    class func downloadWith(url:String?, identifier : String, success : (identifier : String)->(), error : (identifier : String) -> ()){
        
        if url == nil{
            error(identifier: identifier)
            return
        }
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let manager = AFURLSessionManager(sessionConfiguration: config)
        let request = NSURLRequest(string: url)
        let task = manager.downloadTaskWithRequest(request, progress: nil, destination: { (urlObj, response) -> NSURL in
            return getFullPath(url!)
            }) { (response, urlObj, e) in
                if e != nil{
                    error(identifier: identifier)
                    return
                }
                success(identifier: identifier)
        }
        
        task.resume()
        
    }
    
    class func dataFromUrl(url : String?) -> NSData?{
        if String.isEmptyStr(url){
            return nil
        }
        
        let exist = NSFileManager.defaultManager().fileExistsAtPath(getFullPath(url!).path!)
        
        if exist {
            let data = NSData(contentsOfURL: NSURL(string: url!)!)
            return data
        }
        
        return nil
    }
    
    class func imageFromUrl(url : String?) -> UIImage?{
        let data = dataFromUrl(url)
        
        if data == nil{
            return nil
        }
        
        let image = UIImage(data: data!)
        return image
    }
    
    class func getFullPath(urlStr : String) -> NSURL{
        
        let directory = try! NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false)
        let fullPath = directory.URLByAppendingPathComponent(fileNameByUrl(urlStr))
        return fullPath
    }
    
    class func fileNameByUrl(url:String) -> String{
        let fileExtension = (url as NSString).pathExtension
        
        let md5Name = (url as NSString).MD5String()
        
        if String.isEmptyStr(fileExtension){
            return "\(md5Name)"
        }
        
        return "\(md5Name).\(fileExtension)"
    }

}
