//
//  AvatarView.swift
//  userinterface
//
//  Created by Дарья Шимко on 20.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

@IBDesignable class AvatarView: UIView {


    @IBInspectable var shadowRadius: CGFloat = 10 {
        didSet {
            self.configure()
            
        }
    }
    
    @IBInspectable var shadowColor: CGColor = UIColor.black.cgColor {
        didSet {
            self.configure()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.8 {
        
        didSet {
            self.configure()
        }
    }
    
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    func configure() {
        
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius  = 10
        
        
        
    }
    
    	
}
