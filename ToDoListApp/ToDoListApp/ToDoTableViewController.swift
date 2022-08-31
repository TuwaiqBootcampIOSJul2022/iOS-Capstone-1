//
//  ToDoTableViewController.swift
//  ToDoListApp
//
//  Created by Raneem Alkahtani on 26/08/2022.
//

import UIKit
 

class ToDoTableViewController: UITableViewController {

    @IBOutlet weak var SaveButton: UIBarButtonItem!
    
    @IBOutlet weak var NameField: UITextField!
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var NoteDetails: UITextView!
    
    @IBOutlet weak var IsCompletedSwitch: UISwitch!
    
    var toDoItem: ToDoItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if toDoItem == nil{
        toDoItem = ToDoItem(name: "", dateCreated: Date(), DueDate: Date(), notes: "" , isCompleted: false)
        }
        NameField.text = toDoItem.name
        DatePicker.date = toDoItem.DueDate
        NoteDetails.text = toDoItem.notes
       // IsCompletedSwitch.isOn = toDoItem.isCompleted
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name: NameField.text!, dateCreated: DatePicker.date, DueDate: DatePicker.date, notes: NoteDetails.text, isCompleted: false)
    }
  
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode{
            dismiss(animated: true,completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
