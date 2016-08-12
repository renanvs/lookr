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
            return getFullPath(url!, appendName: nil)
            }) { (response, urlObj, e) in
                if e != nil{
                    error(identifier: identifier)
                    return
                }
                success(identifier: identifier)
        }
        
        task.resume()
        
    }
    
    class func existFileByUrl(url : String, appendName:String?) -> Bool{
        let exist = NSFileManager.defaultManager().fileExistsAtPath(getFullPath(url, appendName: appendName).path!)
        return exist
    }
    
    class func dataFromUrl(url : String?, appendName : String?) -> NSData?{
        if String.isEmptyStr(url){
            return nil
        }
        
        
//        var urlFinal = url!;
//        if !(String.isEmptyStr(appendName)){
//            urlFinal = fileNameByUrl(url!, appendName: appendName!)
//        }
        
        let path = getFullPath(url!, appendName: appendName)
        
        if existFileByUrl(url!, appendName: appendName) {
            let data = NSData(contentsOfURL: path)
            return data
        }
        
        return nil
    }
    
    class func imageFromUrl(url : String?, appendName : String?) -> UIImage?{
        let data = dataFromUrl(url, appendName : appendName)
        
        if data == nil{
            return nil
        }
        
        let image = UIImage(data: data!)
        return image
    }
    
    class func getFullPath(urlStr : String, appendName : String?) -> NSURL{
        
        let directory = try! NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomain: NSSearchPathDomainMask.UserDomainMask, appropriateForURL: nil, create: false)
        let fullPath = directory.URLByAppendingPathComponent(fileNameByUrl(urlStr, appendName: appendName))
        return fullPath
    }
    
    class func fileNameByUrl(url:String, appendName : String?) -> String{
        let fileExtension = (url as NSString).pathExtension
        
        var md5Name = (url as NSString).MD5String()
        
        if !(String.isEmptyStr(appendName)){
            md5Name = "\(md5Name)\(appendName!)"
        }
        
        if String.isEmptyStr(fileExtension){
            return "\(md5Name)"
        }
        
        return "\(md5Name).\(fileExtension)"
    }

}
