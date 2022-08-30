//
//  EntryViewController.swift
//  ToDoList
//
//  Created by Rashed Shrahili on 02/02/1444 AH.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    
    var update: (() -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleTextField.delegate = self
    }
    
    @IBAction func doneTask(_ sender: UIBarButtonItem) {
        
        saveTask()
        
    }
    
    
}

extension EntryViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if titleTextField.text?.isEmpty == false {
            
            saveTask()
            
        }
        
        return true
        
    }
    
    @objc func saveTask() {
        
        guard let textTitle = titleTextField.text , !titleTextField.text!.isEmpty else { return }
        
        guard let count = UserDefaults.standard.value(forKey: "count") as? Int else { return }
        
        let newCount = count + 1
        
        UserDefaults.standard.set(newCount, forKey: "count")
        
        UserDefaults.standard.set(textTitle, forKey: "task_\(newCount)")
        UserDefaults.standard.set(dateDatePicker.date, forKey: "taskDate_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
        
    }
}
