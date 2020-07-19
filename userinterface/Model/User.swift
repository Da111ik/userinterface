//
//  User.swift
//  userinterface
//
//  Created by Дарья Шимко on 16.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class User {
    
    let name: String
    let avaterImage: UIImage?
    let friends: [User]? = nil
    let group: [Group]? = nil
    
    init(_ name: String, _ avaterImage: UIImage) {
        
        self.name = name
        self.avaterImage = avaterImage
    }
    
}
