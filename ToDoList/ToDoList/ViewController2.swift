//
//  ViewController2.swift
//  ToDoList
//
//  Created by Ahmed Salah on 28/08/2022.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func AddToDo(_ sender: Any) {
        var toDo : [String]
        
        let todoObject = UserDefaults.standard.object(forKey: "toDo")
        if let todoSaved = todoObject as? [String]{
            
            toDo = todoSaved
            
            toDo.append(textField.text!)
            print(toDo)
        }else{
            toDo = [textField.text!]
        }
        
        UserDefaults.standard.set(toDo, forKey: "toDo")
        textField.text = ""
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
