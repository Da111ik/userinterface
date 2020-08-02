//
//  ShowImagesViewController.swift
//  userinterface
//
//  Created by Дарья Шимко on 29.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class ShowImagesViewController: UIViewController {

    var arrayImage = [UIImage]()
    private let imageView: UIImageView = {
       
        let viewImg = UIImageView()
        viewImg.contentMode = .scaleToFill
        viewImg.clipsToBounds = true
        viewImg.translatesAutoresizingMaskIntoConstraints = false
        viewImg.isUserInteractionEnabled = true
        
        return viewImg
    }()
    
    private let backgraundImageView: UIImageView = {
       
        let viewImg = UIImageView()
        viewImg.contentMode = .scaleToFill
        viewImg.clipsToBounds = true
        viewImg.translatesAutoresizingMaskIntoConstraints = false
//        viewImg.isUserInteractionEnabled = true
        
        return viewImg
    }()
       
      
    private var animation: UIViewPropertyAnimator?
    private var currentDirection = -1.0
    private var currentIndex = 0
    private var percent: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout(imgView: backgraundImageView)
        layout(imgView: imageView)
        
        backgraundImageView.alpha = 0.0
        backgraundImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        setImages()
        
        let gesturePan = UIPanGestureRecognizer(target: self, action: #selector(self.onPanImage(_:)))
        imageView.addGestureRecognizer(gesturePan)
        
     }

    private func layout(imgView: UIImageView) {
        
        view.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imgView.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        ])
    }
    
    
    private func setImages() {
       
        let firstImg = arrayImage[currentIndex]
        let nextIndex = currentIndex == arrayImage.count - 1 ? currentIndex : currentIndex + 1
        var backgroundImg = backgraundImageView.image
        
        if currentDirection == 1 && currentIndex - 1 >= 0 {
            backgroundImg = arrayImage[currentIndex - 1]
        }
        else {
            backgroundImg = arrayImage[nextIndex]
        }
        
        
        imageView.image = firstImg
        backgraundImageView.image = backgroundImg
        
        
    }
    
    private func initAnimator() {
        
        animation?.stopAnimation(true)
        animation = UIViewPropertyAnimator(duration: 0.3, curve: .linear, animations: {
            
            let width = CGFloat(self.currentDirection) * self.view.frame.width
            let translationTransform = CGAffineTransform(translationX: width, y: 0)
            let angle = CGFloat(self.currentDirection * 0.8)
            
            let angleTransform = CGAffineTransform(rotationAngle: angle)
            
            self.imageView.transform = angleTransform.concatenating(translationTransform)
            
            self.backgraundImageView.alpha = 1.0
            self.backgraundImageView.transform = .identity
        })
        
        animation?.startAnimation()
        animation?.pauseAnimation()
        
    }
    
    private func resetImageViews() {
        
        backgraundImageView.alpha = 0
        backgraundImageView.transform = .init(scaleX: 0.8, y: 0.8)
        
        imageView.transform = .identity
        
        setImages()
        view.layoutIfNeeded()
        currentDirection = 0
        animation = nil
        
    }
    
    
    @objc func onPanImage(_ gesture: UIPanGestureRecognizer) {
            
        switch gesture.state {

        case .began:
            let translationX = gesture.translation(in: self.view).x
            let direction = translationX == 0 ? 1 : translationX / abs(translationX)
            
            if animation == nil || direction != CGFloat(currentDirection) {
                animation?.stopAnimation(true)
                resetImageViews()
                animation = nil
                
                
                if  (direction > 0 && currentIndex > 0) || (direction < 0 && currentIndex < arrayImage.count - 1) {
                    currentDirection = Double(direction)
                    setImages()
                    initAnimator()
                }
            }
           
            animation?.fractionComplete = abs(translationX) / (self.view.frame.width / 2)
            
        case .ended:
            
            let translationX = gesture.translation(in: self.view).x
            percent = abs(translationX) / self.view.frame.width
            
            animation?.addCompletion({ (position) in
                self.resetImageViews()
            })
            
            if percent < 0.20 {
                animation?.stopAnimation(true)
                UIView.animate(withDuration: 0.2) {
                    self.resetImageViews()
                }
            }
            else {
                currentIndex += Int(currentDirection) * -1
                animation?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }

        default:
            break
        }

        
    }
}

