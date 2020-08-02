//
//  FriendsCollectionCellView.swift
//  userinterface
//
//  Created by Дарья Шимко on 16.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class FriendsCollectionCellView: UICollectionViewCell {
    
    @IBOutlet weak var avatarFiend: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let pageLike = PageLike()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(pageLike)
        
        pageLike.translatesAutoresizingMaskIntoConstraints = false
        
        let pageLikeConstraints =    [
            pageLike.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageLike.widthAnchor.constraint(equalToConstant: 25),
            pageLike.topAnchor.constraint(equalTo: avatarFiend.bottomAnchor, constant: 5),
            pageLike.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(pageLikeConstraints)
        
        
    }
    
  
}
