//
//  TaskCellTableViewCell.swift
//  To-do List  - Maan Alsalman
//
//  Created by Maan Abdullah on 27/08/2022.
//

import UIKit
class TaskCellTableViewCell: UITableViewCell {
    //MARK: - IBOutlets:
    
    @IBOutlet weak var isCompletedBtn: UIButton!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Methods:
    
    func checkDueDate(dueDate: Date?){
        if let temp = dueDate{
            if temp <= Date(){
                dueDateLabel.isEnabled = true
                dueDateLabel.text = temp.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
                dueDateLabel.textColor = .red
            }
            else{
                dueDateLabel.isEnabled = true
                dueDateLabel.text = temp.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
                dueDateLabel.textColor = .black
            }
        }
        else{
            dueDateLabel.text = ""
        }
    }
}
