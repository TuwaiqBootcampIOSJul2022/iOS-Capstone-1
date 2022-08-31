//
//  ExViewController.swift
//  BookTableView
//
//  Created by Kholoud Almutairi on 29/01/1444 AH.
//

import Foundation
import UIKit

extension toDosVC : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listToDos.count
        }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyListTabel.dequeueReusableCell(withIdentifier: "custemCell", for: indexPath) as! ToDosCell
        cell.labelTitel.text = listToDos[indexPath.row].titel
        cell.dateLabel.text = listToDos[indexPath.row].date
       /* if cell.dateLabel.text == cell.dateLabel.text{
            cell.backgroundColor = .white
        }else{
            cell.backgroundColor = .red
        }*/
       
        
        return cell
                                                    
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delet = UIContextualAction(style: .destructive, title: "Delete"){  _, _, _ in
            listToDos.remove(at:indexPath.row)
            self.MyListTabel.reloadData()
            UserDefaults.standard.set(try? PropertyListEncoder().encode(listToDos), forKey: "MyData")
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delet])
        return swipeConfiguration
    }
    
    
}


