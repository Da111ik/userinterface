//
//  Session.swift
//  userinterface
//
//  Created by Дарья Шимко on 12.08.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import Foundation

class Session {
    
    var token: String = ""
    var userId: Int = 0
    
    public static let shared = Session()
    
    private init() {
        
    }
}
