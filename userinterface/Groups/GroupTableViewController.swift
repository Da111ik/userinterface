//
//  GroupTableViewController.swift
//  userinterface
//
//  Created by Дарья Шимко on 05.07.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arrayGroups: [Group] = [Group("Наш art", UIImage(named: "group_0")),
                       Group("Кисти, краски и бумага (ККБ)", UIImage(named: "group_1")),
                       Group("Лето-весна", UIImage(named: "group_2")),
                       Group("Асьминожка", UIImage(named: "group_3")),
                       Group("Кислотный DJ", UIImage(named: "group_4")),
                       Group("По просторам неба", UIImage(named: "group_5")),
                       Group("Жиза кабза", UIImage(named: "group_6")),
                       Group("Хакапрог", UIImage(named: "group_7")),
                       Group("Карпаты вам рады", UIImage(named: "group_8"))]


    private var filterGoups = [Group]()

    
    override func viewDidLoad(	) {
        super.viewDidLoad()
        tableView.rowHeight = 60
        
        searchBar.delegate = self
        filterGoups = arrayGroups
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return filterGoups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupTableCellView else {
            fatalError()
        }
        
        cell.nameGroup.text = filterGoups[indexPath.row].name
        cell.imageGroup.image = filterGoups[indexPath.row].avatarImage
        
        return cell
    }
    
    @IBAction func addGroup(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Enter the new name group", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Default action"), style: .default, handler: {
            [weak self, weak alert] (action) in
                guard let textField = alert?.textFields?.first else { return }
                self!.addGroup(newStringGroup: textField.text!)
        })
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "name group"
        })
       
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: {})
        
        
    }
    
    func addGroup(newStringGroup: String) {
     
        guard !newStringGroup.isEmpty else { return }
        
        var existGroup = false
        
        for currentGroup in arrayGroups {
            if currentGroup.name == newStringGroup {
                existGroup = true
                break
            }
        }
        
        if !existGroup {
            let newGroup = Group(newStringGroup, UIImage())
            arrayGroups.insert(newGroup, at: 0)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            arrayGroups.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .bottom)
            tableView.endUpdates()
            
        }
        
        
    }

}


extension GroupTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filterGoups = arrayGroups
        }
        else {
            filterGoups = arrayGroups.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}
