//
//  FiendsCollectionViewController.swift
//  userinterface
//
//  Created by Дарья Шимко on 05.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class FriendsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var user: User?
    
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.delegate = self
            
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilFriendCell", for: indexPath) as! FriendsCollectionCellView
        
        cell.avatarFiend?.image = user?.avaterImage
        cell.nameLabel?.text = user?.name
 
        return cell
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        guard let showImageVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "showImages") as? ShowImagesViewController else { return }
        
        var arrayImage = [UIImage]()
        arrayImage.append(user?.avaterImage ?? UIImage())
        arrayImage.append(UIImage(named: "group_1")!)
        arrayImage.append(UIImage(named: "group_2")!)
        
        showImageVC.arrayImage = arrayImage
        
        present(showImageVC, animated: true, completion: nil)
    }
}

extension FriendsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: collectionView.frame.width - 20, height: collectionView.frame.height / 2)

    }
}
