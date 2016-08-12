//
//  LKExtensions.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit
import CoreData

class LKExtensions: NSObject {

}

/*
 var date:NSDate!{
 get{
 let formatter = NSDateFormatter()
 formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//2016-04-06T00:00:00
 
 if self.dateCreatedStr.containsString("."){
 formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"//2016-05-19T11:39:39.007
 }
 
 return formatter.dateFromString(self.dateCreatedStr!)
 }
 set(value){
 let formatter = NSDateFormatter()
 formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//2016-04-06T00:00:00
 self.dateCreatedStr = formatter.stringFromDate(value)
 }
 }
 */

extension NSDate{
    class func LK_AgoTextValue(dateStr : String?) -> String?{
        if String.isEmptyStr(dateStr){
            return nil
        }
        
        let dateString = dateStr!
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//2016-04-06T00:00:00
        
        if dateString.containsString("."){
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"//2016-05-19T11:39:39.007
        }
        
        let date = formatter.dateFromString(dateString)
        if date == nil{
            return nil
        }
        
        let currentDate = NSDate()
        let diferenceSeconds = currentDate.timeIntervalSinceDate(date!)
        let diferenceMinutes = diferenceSeconds/60
        let diferenceHours = diferenceMinutes/60
        let diferenceDays = diferenceHours/24
        
        
        if diferenceSeconds < 60  {
            return "< 1min"
        }else if diferenceMinutes < 60  {
            return "\(String(format: "%.0f", diferenceMinutes))mins"
        }else if diferenceHours < 24  {
            return "\(String(format: "%.0f", diferenceHours))hrs"
        }else if diferenceDays < 365  {
            return "\(String(format: "%.0f", diferenceDays))days"
        }
        
        return nil
    }
    
}

extension UIView{
    func LK_RoundBorderAsCircle(){
        self.layer.cornerRadius = self.widthSize()/2
        self.layer.masksToBounds = true
    }
}

extension UILabel{
    func LK_FontRegular(){
        self.font = UIFont.LK_FontRegular(self.font!.pointSize)
    }
    
    func LK_FontBold(){
        self.font = UIFont.LK_FontBold(self.font!.pointSize)
    }
    
    func LK_FontRegularWithSize(size : Float){
        return self.font = UIFont.LK_FontRegular(CGFloat(size))
    }
    
    func LK_FontBoldWithSize(size : Float){
        return self.font = UIFont.LK_FontBold(CGFloat(size))
    }
}

extension UIFont{
    class func LK_FontBold(size : CGFloat) -> UIFont{
        return UIFont(name: "Roboto-Bold", size: size)!
    }
    
    class func LK_FontRegular(size : CGFloat) -> UIFont{
        return UIFont(name: "Roboto-Regular", size: size)!
    }
}

extension UIImage{
    class func LK_Image(url:String?) -> UIImage?{
        return LKDownloadManager.imageFromUrl(url, appendName : nil)
    }
    
    class func LK_ThumbImage(url:String?) -> UIImage?{
        return LKDownloadManager.imageFromUrl(url, appendName : "_thumb")
    }
    
    class func LK_ScreenImage(url:String?) -> UIImage?{
        return LKDownloadManager.imageFromUrl(url, appendName : "_screen")
    }
    
    class func LK_NotExistImageAndCanDownload(url:String?) -> Bool{
        if String.isEmptyStr(url){
            return false
        }
        
        if LKDownloadManager.existFileByUrl(url!, appendName: nil){
            return false
        }
        
        return true
    }
}

extension NSManagedObject{
    class func LK_CreateEntity() -> NSManagedObject{
        let ctx = LKCoreDataBase.sharedInstance.managedObjectContext
        let entity = NSEntityDescription.insertNewObjectForEntityForName(entityName(), inManagedObjectContext: ctx)
        return entity
    }
    
    private class func entityName() -> String{
        let name = NSStringFromClass(self).componentsSeparatedByString(".").last!
        return name
    }
    
    class func LK_FindAll() -> [NSManagedObject]{
        return LK_FindAllWithPredicate(nil)
    }
    
    class func LK_FindAllWithPredicate(predicate : NSPredicate?) -> [NSManagedObject]{
        let ctx = LKCoreDataBase.sharedInstance.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName(entityName(), inManagedObjectContext: ctx)
        
        let fetch = NSFetchRequest()
        fetch.entity = entityDescription
        
        if predicate != nil{
            fetch.predicate = predicate!
        }
        
        var list = [NSManagedObject]()
        
        do{
            try list = ctx.executeFetchRequest(fetch) as! [NSManagedObject]
        }catch{
            print(error)
        }
        return list
    }
    
    class func LK_FindUniqueWithPredicate(predicate : NSPredicate?) -> NSManagedObject?{
        let list = LK_FindAllWithPredicate(predicate)
        if list.count == 0{
            return nil
        }
        
        return list.first
    }

    
    class func LK_FindEntityWithIdentifier(identifier : NSString) -> NSManagedObject?{
        let predicate = NSPredicate(format: "identifier == %@", identifier)
        let list = LK_FindAllWithPredicate(predicate)
        
        if list.count > 0{
            return list.first!
        }
        
        return nil
    }

}