//
//  LKTimeLineViewController.swift
//  Lookr
//
//  Created by renan silva on 8/7/16.
//  Copyright © 2016 rvsz. All rights reserved.
//

import UIKit

class LKTimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list = [TimelinePublicationEntity]()
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = TimelinePublicationEntity.getAll()
        
        let nib = UINib(nibName: "LKPublicationCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "LKPublicationCell")
        
        //tableView.registerClass(LKPublicationCell.self, forCellReuseIdentifier: "LKPublicationCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        LKTimelineRequestService.getTimeline({
            self.list = TimelinePublicationEntity.getAll()
            self.tableView.reloadData()
            
            }) { (error, response) in
                LKUtils.simpleAlert("TimeLineError: \(error)")
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let publicationEntity = list[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("LKPublicationCell", forIndexPath: indexPath) as! LKPublicationCell
        cell.setupWithPublication(publicationEntity)
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LKPublicationCell.heightCell()
    }
}
