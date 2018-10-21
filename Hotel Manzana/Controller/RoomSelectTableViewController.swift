//
//  RoomSelectTableViewController.swift
//  Hotel Manzana
//
//  Created by Evgeniy Ryshkov on 21/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

class RoomSelectTableViewController: UITableViewController {

    let rooms = Rooms.content.rooms
    
    var selectedRoom: RoomType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isScrollEnabled = false
        
//        self.view.layer.cornerRadius = 15.0
//        self.view.layer.borderWidth = 1.5
//        self.view.layer.borderColor = UIColor.black.cgColor
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rooms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)

        cell.textLabel?.text = rooms[indexPath.row].shortName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRoom = rooms[indexPath.row]
        performSegue(withIdentifier: "unwindToAddRegistrationVC", sender: nil)
    }

}
