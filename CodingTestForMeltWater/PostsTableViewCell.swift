//
//  PostsTableViewCell.swift
//  CodingTestForMeltWater
//
//  Created by Jeswanth Bonthu on 1/23/17.
//  Copyright © 2017 Jeswanth Bonthu. All rights reserved.
//

import Foundation
import UIKit

class PostsTableViewCell: UITableViewCell {
    
     //MARK: - IB Properties
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
