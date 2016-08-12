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
    @IBOutlet var borderUserView : UIView!
    
    @IBOutlet var publicationeImage : UIImageView!
    @IBOutlet var userLabel : UILabel!
    @IBOutlet var publicationTime : UILabel!
    
    @IBOutlet var likeButton : UIButton!
    @IBOutlet var dislikeButton : UIButton!
    @IBOutlet var commentsButton : UIButton!
    
    var publicationEntity : BasePublicationEntity!
    
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
        
        resetImages()
        
        self.publicationEntity = publication
        userLabel.text = publication.text
        publicationTime.text = NSDate.LK_AgoTextValue(publication.dateStr)
        likeButton.setTitle(publication.qtyLikes.stringValue, forState: UIControlState.Normal)
        dislikeButton.setTitle(publication.qtyDislikes.stringValue, forState: UIControlState.Normal)
        commentsButton.setTitle(publication.qtyComments.stringValue, forState: UIControlState.Normal)
        
        setupLayout()
        setImages()
        
    }
    
    private func setupLayout(){
        userImage.LK_RoundBorderAsCircle()
        borderUserView.LK_RoundBorderAsCircle()
        borderUserView.backgroundColor = UIColor.whiteColor()
        likeButton.clearColor()
        dislikeButton.clearColor()
        commentsButton.clearColor()
        self.clearColorCellAndContent()
    }
    
    func resetImages(){
        publicationeImage.image = nil
        userImage.image = nil
    }
    
    func setImages(){
        let publicationURI = publicationEntity.defaultPublicationImageEntity()?.imageURI
        publicationeImage.image = UIImage.LK_ScreenImage(publicationURI)
        
        if publicationeImage.image == nil{
            LKUtils.downloadAndGenerateImages(publicationURI, identifier: publicationEntity.identifier, success: { (identifier) in
                
                if identifier == self.publicationEntity.identifier{
                    self.publicationeImage.image = UIImage.LK_ScreenImage(publicationURI)
                }
                
                }, error: { (identifier) in
            })
        }
        
        let userURI = publicationEntity.user.photoURI
        userImage.image = UIImage.LK_Image(userURI)
        
        if userImage.image == nil{
            LKDownloadManager.downloadWith(userURI, identifier: publicationEntity.identifier, success: { (identifier) in
                
                if identifier == self.publicationEntity.identifier{
                    self.userImage.image = UIImage.LK_Image(userURI)
                }
                
                }, error: { (identifier) in
            })
        }
        
    }

}
