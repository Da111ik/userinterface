//
//  LoginController.swift
//  userinterface
//
//  Created by Дарья Шимко on 01.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       

       NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)

       NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        scrollView.addGestureRecognizer(tapGesture)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func tapGesture() {
        scrollView.endEditing(true)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        let userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardFrame.size.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHidden(notification: Notification) {
     
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }

    
    @IBAction func singIn(_sender: UIButton) {
        
        if loginText.text! == "admin" && passwordText.text! == "12345" {
            
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "tabBar") as? UITabBarController else { return }
        
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(vc, animated: true, completion: nil)
                 
            return
            
        } else {
    
            showAlertLogin("Error", message: "Your login or password is not correct")
            
            
        }
        
    }
    
    func showAlertLogin(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil)
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

