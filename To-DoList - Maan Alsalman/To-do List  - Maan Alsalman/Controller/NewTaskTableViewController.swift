//
//  NewTaskTableViewController.swift
//  To-do List  - Maan Alsalman
//
//  Created by Maan Abdullah on 27/08/2022.
//

import UIKit
class NewTaskTableViewController: UITableViewController {
    // MARK: - IBOutlets:
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueDateSwitch: UISwitch!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var desTextView: UITextView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet var newTaskTableView: UITableView!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    //MARK: - Variables & Constants
    let dueDateIndexPath = IndexPath(row: 2, section: 0)
    let switchIndexPath = IndexPath(row: 1, section: 0)
    let desTextViewIndexPath = IndexPath(row: 0, section: 1)
    var currentRow = 0
    var isEditingCell = false
    var data: Task?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        desTextView.delegate = self
        taskNameTextField.delegate = self
        
        updateFields()
        minimumSelectDate()
        updateDueDateLabel(dueDatePicker.date)
        updateSaveBtnStatus()
        tableViewPlaceHolder()
        taskNameTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    
    // MARK: - IBActions:
    
    @IBAction func dueDateSwitchBtn(_ sender: UISwitch) {
        dueDateSwitch.isOn = sender.isOn
        newTaskTableView.beginUpdates()
        newTaskTableView.endUpdates()
    }
    
    @IBAction func dueDateChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(sender.date)
    }
    
    //MARK: - Methods
    
    func minimumSelectDate() {
       let currentDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
       dueDatePicker.minimumDate = currentDate
   }
    
    func updateDueDateLabel(_ date: Date){
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
    func updateFields(){
        if isEditingCell {
            if let tempData = data{
            taskNameTextField.text = tempData.title
            if let tempNote = tempData.notes{
            desTextView.text = tempNote
            }
            else{
                desTextView.text = nil
                tableViewPlaceHolder()
                }
            if let tempDate = tempData.dueDate{
                dueDateSwitch.isOn = true
                dueDateSwitchBtn(dueDateSwitch)
                dueDateLabel.text = tempDate.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
                dueDatePicker.date = tempDate
                }
                
            }
            
        }
    }
        func updateSaveBtnStatus(){
            if taskNameTextField.text?.isEmpty == false{
                saveBtn.isEnabled = true
            }
        }


    //MARK: - TableView Methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == dueDateIndexPath && !dueDateSwitch.isOn{
            return 0
        }
        else if indexPath == desTextViewIndexPath{
            return 300
        }
        else{
            return UITableView.automaticDimension
        }
    }
    
    func tableViewPlaceHolder() {
        if desTextView.text.isEmpty == true || desTextView.text == "Task Description"{
            desTextView.text = "Task Description"
            desTextView.textColor = .lightGray
            
        }
   }
    

// MARK: - Passing Data:
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveSegue" else{return}
        if dueDateSwitch.isOn{
            data = Task(title: taskNameTextField.text!, notes: desTextView.text, isCompleted: data?.isCompleted ?? false, dueDate: dueDatePicker.date)
        }
        else{
             data = Task(title: taskNameTextField.text!, notes: desTextView.text, isCompleted: data?.isCompleted ?? false, dueDate: nil)
        }
        if isEditingCell == true{
            arrayTask[currentRow] = data!
        }
        else{
            arrayTask.append(data!)
        }
        Task.saveTasksData(arrayTask)
    }
}

// MARK: - applying some functions to textView
extension NewTaskTableViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray{
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "Task Description"
            textView.textColor = .lightGray
        }
    }
}

// MARK: - applying some functions to task name textField

extension NewTaskTableViewController: UITextFieldDelegate{
    
    @objc func textChanged(textField: UITextField){
        guard let temp = textField.text?.trimmingCharacters(in: .whitespaces) else{return}
        if !temp.isEmpty{
            saveBtn.isEnabled = true
        }
        else{
            saveBtn.isEnabled = false

        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskNameTextField{
            dueDateSwitch.isOn = true
            dueDateSwitchBtn(dueDateSwitch)
    }
        return true
}
}
