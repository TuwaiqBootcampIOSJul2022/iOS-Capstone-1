//
//  ViewController2.swift
//  ListsToDo-App
//
//  Created by Hessa on 28/01/1444 AH.
//

import UIKit

protocol ViewControllerDelegate {
    func sendDataToFirstViewController(ListArr: [mydata])
}

class ViewController2: UIViewController {
   
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var ListTitle: UITextView!
    
    var dateField = ""
    var ToDoLists = [mydata]()
    var delegate: ViewControllerDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        ListTitle.becomeFirstResponder()
        textfield.text = dateField
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let AddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(DismissVC))
        self.navigationController?.navigationBar.backgroundColor = UIColor.colorFromRGB(0x76BDB2)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = AddButton
        self.title = "New Task"
        
    
    }
    
    @objc func DismissVC()
    {
      ToDoLists.append(mydata(taskName: ListTitle.text, dateDisplay: textfield.text!))
        self.delegate.sendDataToFirstViewController(ListArr: ToDoLists)
        dismiss(animated: true)

    }

    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm"
        dateFormatter.dateStyle = DateFormatter.Style.short

        let date = dateFormatter.string(from: datepicker.date)
        textfield.text = date
    }
 
}
