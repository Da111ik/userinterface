//
//  NewsTableViewCell.swift
//  userinterface
//
//  Created by Дарья Шимко on 26.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var heartImage: UIImageView!
    
    @IBOutlet weak var heardLabel: UILabel!
    
    @IBOutlet weak var commentImage: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var watchImage: UIImageView!
    
    @IBOutlet weak var watchLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
