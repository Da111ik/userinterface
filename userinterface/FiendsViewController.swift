//
//  FiendsTableViewController.swift
//  userinterface
//
//  Created by Дарья Шимко on 05.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    
    let arrayFriends = [User("Александр", UIImage(named: "friend_0")!),
                        User("Василий", UIImage(named: "friend_1")!),
                        User("Диана", UIImage(named: "friend_2")!),
                        User("Данил", UIImage(named: "friend_3")!),
                        User("Сергей", UIImage(named: "friend_4")!),
                        User("Мария", UIImage(named: "friend_5")!),
                        User("Алексей", UIImage(named: "friend_6")!),
                        User("Роман", UIImage(named: "friend_7")!),
                        User("Петр", UIImage(named: "friend_8")!),
                        User("Анастасия", UIImage(named: "friend_9")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsTableCellView else { fatalError() }
       

        cell.nameFriend.text = arrayFriends[indexPath.row].name
        cell.imageFriend.image = arrayFriends[indexPath.row].avaterImage
        
        return cell
        
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let transfer: FriendsCollectionViewController = segue.destination as! FriendsCollectionViewController
        
        transfer.user = arrayFriends[indexPath!.row]

    }
}


