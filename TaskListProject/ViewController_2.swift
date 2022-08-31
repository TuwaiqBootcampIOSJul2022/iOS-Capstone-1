//
//  ViewController_2.swift
//  TaskListProject
//
//  Created by Anaal Albeeshi on 02/02/1444 AH.
//

import UIKit

class ViewController_2: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var task: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done , target: self, action: #selector(deleteTask))

        // Do any additional setup after loading the view.
    }
    
    @objc func deleteTask() {
        
//        let newCount = count - 1
//        UserDefaults().setValue(newCount, forKey: "count")
//        UserDefaults().setValue(nil, forKeyPath: "task_\(currentPosition)")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        performSegue(withIdentifier: "move1", sender: nil)
    }

}// end of class
