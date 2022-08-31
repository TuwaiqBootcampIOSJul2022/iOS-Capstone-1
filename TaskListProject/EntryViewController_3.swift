//
//  DeleteViewController_3.swift
//  TaskListProject
//
//  Created by Anaal Albeeshi on 02/02/1444 AH.
//

import UIKit

class EntryViewController_3: UIViewController, UITextFieldDelegate {
    
//    var update: (() -> Void)? // or (() -> ())?
    
    @IBOutlet weak var field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func  saveTask(){
        
        guard let text = field.text, !text.isEmpty else{
            print("bbhhhhh")
            return
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        print("user default: \(UserDefaults.standard.dictionaryRepresentation())")
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_ \(newCount)")
//        update?()
        navigationController?.popViewController(animated: true)
        
        
    }
}
