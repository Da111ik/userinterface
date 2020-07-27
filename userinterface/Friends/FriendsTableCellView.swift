//
//  FriendsTableCellView.swift
//  userinterface
//
//  Created by Дарья Шимко on 12.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class FriendsTableCellView: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var nameFriend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapAvatarImage(_:)))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGesture)
    }
    
   
    @objc func tapAvatarImage(_ sender: UITapGestureRecognizer) {
      
        UIView.animate(withDuration: 2, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.avatarImage.bounds = CGRect(x: 0, y: 0, width: self.avatarImage.bounds.width - 4, height: self.avatarImage.bounds.height - 4)
        })
        

    }
}
