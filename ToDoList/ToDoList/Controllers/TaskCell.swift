//
//  TaskCell.swift
//  ToDoList
//
//  Created by Rashed Shrahili on 01/02/1444 AH.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var taskDate: UILabel!
    
    @IBOutlet weak var taskLate: UILabel!
    
    @IBOutlet weak var taskComplete: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func taskComplete(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(systemName: "circle") {
            
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            sender.tintColor = .systemYellow
            
            //UserDefaults.standard.set(true, forKey: "taskComplete_\(sender.tag)")
            
        } else {
            
            
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
            sender.tintColor = .darkGray
            
            //UserDefaults.standard.set(false, forKey: "taskComplete_\(sender.tag)")
        }
    }
    
    
}
