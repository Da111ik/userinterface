//
//  PageLike.swift
//  userinterface
//
//  Created by Дарья Шимко on 20.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

@IBDesignable class PageLike: UIControl, UIGestureRecognizerDelegate {


    private var countLike: Int = 0
    private var countLikeLabel: UILabel = UILabel()
    private var heartButton: UIButton = UIButton(type: .system)
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
         

        self.heartButton.translatesAutoresizingMaskIntoConstraints = false
        self.countLikeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(heartButton)
        self.addSubview(countLikeLabel)
        
         
        let imageConstraint = [
            heartButton.leftAnchor.constraint(equalTo: leftAnchor),
            //heartButton.rightAnchor.constraint(equalTo: countLikeLabel.leftAnchor),
            heartButton.widthAnchor.constraint(equalTo: heartButton.heightAnchor),
            heartButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            heartButton.heightAnchor.constraint(equalToConstant: 20)
            
        ]
        
        let labelConstrains = [
            countLikeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLikeLabel.leftAnchor.constraint(equalTo: heartButton.rightAnchor, constant: 10)
        ]
         
        NSLayoutConstraint.activate(imageConstraint + labelConstrains)
        
        self.countLikeLabel.text = "0"
        self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    
        self.heartButton.addTarget(self, action: #selector(imageTapped(_:)), for: .touchUpInside)

    }

    
    @objc func imageTapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(systemName: "heart") {
            self.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

            self.countLike += 1
            self.countLikeLabel.text = String(self.countLike)
        }
        else {

            self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)

            self.countLike -= 1
            self.countLikeLabel.text = String(self.countLike)
        }
               

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //self.frame = bounds
    }
    	
    
}
