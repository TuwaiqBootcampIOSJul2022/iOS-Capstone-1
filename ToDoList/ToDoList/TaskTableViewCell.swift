//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by NosaibahMW on 01/02/1444 AH.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDueDate: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var delegate: TableViewCellDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func checkButtonAction(_ sender: Any) {
        delegate?.checkButtonChecked(cell: self)
    }
    
    @IBAction func deleteTaskAction(_ sender: Any) {
        delegate?.deleteButtonClicked(cell: self)
        
    }
    
    @IBAction func editTaskAction(_ sender: Any) {
        delegate?.editButtonClicked(cell: self)
    }
    
    
    
}

//create protocol that allow us to pass cell info. to tableView class
protocol TableViewCellDelegate {
    func checkButtonChecked(cell: TaskTableViewCell)
    
    func deleteButtonClicked(cell: TaskTableViewCell)
    
    func editButtonClicked(cell: TaskTableViewCell)
    
}
