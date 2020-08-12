//
//  CusomNavigationControllerViewController.swift
//  userinterface
//
//  Created by Дарья Шимко on 03.08.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class CusomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
    }
   
   
}


extension CusomNavigationController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return CustomPushAnimator()
        }
        else if operation == .pop {
            return CustomPopAnimator()
        }
        
        return nil
    }
}
