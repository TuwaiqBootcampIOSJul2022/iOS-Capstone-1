

import UIKit



class secondToDoTable: UITableViewController {


    @IBOutlet var tableViewStatic: UITableView!
    @IBOutlet weak var duaLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    var taskList : TaskList?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let curDate : Date
        if let taskList = taskList{
            
            navigationItem.title = "To-Do"
            textField.text = taskList.title
            completeBtn.isSelected = taskList.isComplete
            curDate = taskList.dueDate
            textView.text = taskList.notes
            
        } else {
            curDate = Date().addingTimeInterval(12*60*60)
        }
        
        picker.date = curDate
        dateUpdate(date: curDate)
        enableBtn()
        
        enableBtn()
        textView.layer.cornerRadius = 16
        dateUpdate(date: picker.date)
        enableBtn()
        
        picker.date = Date().addingTimeInterval(12*60*60)
        dateUpdate(date: picker.date)
        enableBtn()
    
    }
    
    
    @IBAction func textChange(_ sender: UITextField) {
        enableBtn()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
        
        saveData()

    }
    
    @IBAction func selectBtn(_ sender: UIButton) {
        
    }
    
    func dateUpdate(date: Date) {
        duaLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
    func enableBtn() {
        
        let EnableSaveBtn = textField.text?.isEmpty == false
        saveBtn.isEnabled = EnableSaveBtn
        
    }
    
    @IBAction func dueDate(_ sender: UIDatePicker) {
        
        dateUpdate(date: sender.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "save" else {return}
        
        let title = textField.text!
        let complete = completeBtn.isSelected
        let Date = picker.date
        let note = textView.text
        
        taskList = TaskList(title: title, isComplete: complete, dueDate: Date, notes: note)
        
        if taskList != nil {
            taskList?.title = title
            taskList?.isComplete = complete
            taskList?.dueDate = Date
            taskList?.notes = note
            } else {
                taskList = TaskList(title: title, isComplete: complete,
                   dueDate: Date, notes: note)
            }

    }
    
    @objc func saveData(){
        
        guard let text = textField.text, !text.isEmpty else {return}
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {return}
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")

    }
    
    }

