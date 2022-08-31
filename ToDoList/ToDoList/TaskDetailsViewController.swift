//
//  TaskDetailsViewController.swift
//  ToDoList
//
//  Created by NosaibahMW on 03/02/1444 AH.
//

import UIKit

class TaskDetailsViewController: UIViewController {

    
    var task: Task?
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    @IBOutlet weak var taskDueDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTitleLabel.text = task?.title
        taskDescriptionLabel.text = task?.description
        taskDueDateLabel.text = task?.dueDate
    }

}
