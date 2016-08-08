//
//  LKPublicationCell.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKPublicationCell: UITableViewCell {
    
    @IBOutlet var userImage : UIImageView!
    @IBOutlet var publicationeImage : UIImageView!
    @IBOutlet var userLabel : UILabel!
    @IBOutlet var publicationTime : UILabel!
    
    @IBOutlet var likeButton : UIButton!
    @IBOutlet var dislikeButton : UIButton!
    @IBOutlet var commentsButton : UIButton!
    
    @IBAction func likeButtonHandler(){
        print("likeButtonHandler Pressed")
    }
    
    @IBAction func dislikeButtonHandler(){
        print("dislikeButtonHandler Pressed")
    }
    
    @IBAction func commentsButtonHandler(){
        print("commentsButtonHandler Pressed")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func heightCell() -> CGFloat{
        let cell = Utils.loadNibForName("LKPublicationCell")
        return cell.height()
    }
    
    func setupWithPublication(publication:BasePublicationEntity){
//        userImage
//        publicationeImage
        userLabel.text = publication.text
        publicationTime.text = publication.dateStr
        
        likeButton.setTitle(publication.qtyLikes.stringValue, forState: UIControlState.Normal)
        dislikeButton.setTitle(publication.qtyDislikes.stringValue, forState: UIControlState.Normal)
        commentsButton.setTitle(publication.qtyComments.stringValue, forState: UIControlState.Normal)
    }

}
