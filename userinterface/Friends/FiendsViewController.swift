//
//  FiendsTableViewController.swift
//  userinterface
//
//  Created by Дарья Шимко on 05.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    
    private let arrayFriends = [User("Александр", UIImage(named: "friend_0")!),
                        User("Василий", UIImage(named: "friend_1")!),
                        User("Диана", UIImage(named: "friend_2")!),
                        User("Данил", UIImage(named: "friend_3")!),
                        User("Сергей", UIImage(named: "friend_4")!),
                        User("Мария", UIImage(named: "friend_5")!),
                        User("Алексей", UIImage(named: "friend_6")!),
                        User("Роман", UIImage(named: "friend_7")!),
                        User("Петр", UIImage(named: "friend_8")!),
                        User("Анастасия", UIImage(named: "friend_9")!)]
    
    
    private var section: [Character: [User]] = [:]
    private var sectionTitles = [Character]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filterResult = [User]()
    private var isEmptySearch: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return !isEmptySearch && searchController.isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
               
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true // empties the searchController in other scene
        
    }
       
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        section.removeAll()
        
        if isFiltering {
             
            for user in filterResult {
                if section[user.name.first!] != nil {
                    section[user.name.first!]?.append(user)
                }
                else {
                    section[user.name.first!] = [user]
                }
            
            }
        }
        else {
            for user in arrayFriends {
               if section[user.name.first!] != nil {
                   section[user.name.first!]?.append(user)
               }
               else {
                   section[user.name.first!] = [user]
               }
           }
        }
        sectionTitles = Array(section.keys)
        sectionTitles.sort()

        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          return String(sectionTitles[section])
      }
      
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
          let vw = UIView()
          vw.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.5)
          
          let titleVW = UILabel()
          titleVW.text = String(sectionTitles[section])
          titleVW.font = UIFont(name: "Arial", size: 20)
          
          titleVW.translatesAutoresizingMaskIntoConstraints = false

          vw.addSubview(titleVW)
          
          let constraintsArray = [
              titleVW.leadingAnchor.constraint(equalTo: vw.leadingAnchor, constant: 25),
              titleVW.trailingAnchor.constraint(greaterThanOrEqualTo: vw.trailingAnchor, constant: 100),
              titleVW.centerYAnchor.constraint(equalTo: vw.centerYAnchor)
          ]
      
          vw.addConstraints(constraintsArray)
          

          return vw
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles.map{ String($0) }
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
        
        transfer.user = section[sectionTitles[indexPath!.section]]![indexPath!.row]
        
    }
}

extension FriendsTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
    private func filterContentForSearchText(_ searchText: String) {
     
        if searchText.isEmpty {
            filterResult = arrayFriends
        }
        else {
            filterResult = arrayFriends.filter({ (User) -> Bool in
                return User.name.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
        
}
