//
//  EditTaskPopUpViewController.swift
//  ToDoList
//
//  Created by NosaibahMW on 03/02/1444 AH.
//

import UIKit

class EditTaskPopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBOutlet weak var taskDescriptionTextField: UITextField!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    var index:Int?
    
    var task:Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        popUpView.layer.cornerRadius = 20
        print("Hello from Edit********")
        
        taskTitleTextField.text = task?.title
        taskDescriptionTextField.text = task?.description
        dueDateTextField.text = task?.dueDate
        
        
        createDatePicker()
    }
    

    
    @IBAction func editButtonAction(_ sender: Any) {
        
        var previousVC = ListViewController()
        
        var tempArray:[Task] = previousVC.readData()
        
        tempArray[index!] = Task(title: taskTitleTextField.text!, description: taskDescriptionTextField.text!, isCompleted: tempArray[index!].isCompleted, dueDate: dueDateTextField.text!, isPastDue: tempArray[index!].isPastDue)
        
        previousVC.writeData(tasks: tempArray)
        performSegue(withIdentifier: "taskEditedSegue", sender: nil)
         
    }
    
    
    
    
    
    
    
    
    
    
}

//Custom datePicker
extension EditTaskPopUpViewController {
    
    
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
