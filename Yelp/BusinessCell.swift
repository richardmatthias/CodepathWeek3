//
//  BusinessCell.swift
//  Yelp
//
//  Created by Langtian Qin on 2/13/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    @IBOutlet weak var MLabel: UILabel!
    @IBOutlet weak var DLabel: UILabel!
    @IBOutlet weak var GLabel: UILabel!
    @IBOutlet weak var LLabel: UILabel!
    @IBOutlet weak var RLabel: UILabel!
    @IBOutlet weak var NLabel: UILabel!
    @IBOutlet weak var SView: UIImageView!
    @IBOutlet weak var RView: UIImageView!
    
    var myBusiness:Business!{
        didSet{
            NLabel.text=myBusiness.name
            RLabel.text=myBusiness.reviewCount?.stringValue
            LLabel.text=myBusiness.address
            GLabel.text=myBusiness.categories
            DLabel.text=myBusiness.distance
            SView.setImageWith(myBusiness.imageURL!)
            RView.setImageWith(myBusiness.ratingImageURL!)
            //MLabel.text=myBusiness.
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
