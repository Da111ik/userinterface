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
    
    
    var section: [Character: [User]] = [:]
    var sectionTitles = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        
        for user in arrayFriends {
            if section[user.name.first!] != nil {
                section[user.name.first!]?.append(user)
            }
            else {
                section[user.name.first!] = [user]
            }
        }
       
        sectionTitles = Array(section.keys)
        sectionTitles.sort()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Arial", size: 20)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles.map{ String($0) }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sectionTitles[section])
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.section[sectionTitles[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsTableCellView else { fatalError() }
        guard let user = section[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }

        cell.nameFriend.text = user.name
        cell.avatarImage.image = user.avaterImage
        cell.avatarView.configure()
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let transfer: FriendsCollectionViewController = segue.destination as! FriendsCollectionViewController
        
        transfer.user = arrayFriends[indexPath!.row]

    }
}


