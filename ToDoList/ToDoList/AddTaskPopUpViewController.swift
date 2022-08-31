//
//  PopUpViewController.swift
//  ToDoList
//
//  Created by NosaibahMW on 02/02/1444 AH.
//

import UIKit

class AddTaskPopUpViewController: UIViewController {

    @IBOutlet weak var PopUpView: UIView!
    
    @IBOutlet weak var taskTitleTextFieled: UITextField!
    
    @IBOutlet weak var taskDescritionTextFieled: UITextField!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        PopUpView.layer.cornerRadius = 20
        
        createDatePicker()
    }
    
    
    @IBAction func addTaskButtonClicked(_ sender: Any) {
        var previousVC = ListViewController()
        
        var tempArray:[Task] = previousVC.readData()
        
        tempArray.append(Task(title: taskTitleTextFieled.text!, description: taskDescritionTextFieled.text!, isCompleted: false, dueDate: dueDateTextField.text!, isPastDue: false))
        
        previousVC.writeData(tasks: tempArray)
        performSegue(withIdentifier: "TaskAddedSegue", sender: nil)
   
    }
    
}



//Custom datePicker
extension AddTaskPopUpViewController {
    
    
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneButtonClicked))
        
        
        datePicker.preferredDatePickerStyle = .wheels
        
        dueDateTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        toolbar.setItems([doneButton], animated: true)
        
        dueDateTextField.inputAccessoryView = toolbar
        
    }
    
    @objc func doneButtonClicked(){
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        self.dueDateTextField.text = dateFormat.string(from: datePicker.date)
        
        dueDateTextField.resignFirstResponder()
    }
    
    
}
