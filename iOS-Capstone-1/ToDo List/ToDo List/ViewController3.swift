//
//  ViewController3.swift
//  ToDo List
//
//  Created by Kholoud Almutairi on 02/02/1444 AH.
//

import UIKit

protocol AddTask{
  
    func addTask(name: String , details : String , Date : String )
    
}

class ViewController3: UIViewController {
    

    @IBOutlet weak var NewTaskTF: UITextField!
    @IBOutlet weak var DescribeTX: UITextField!
    @IBOutlet weak var DateTX: UITextField!
    @IBOutlet weak var AddButoonOut: UIButton!
    
let DatePicker = UIDatePicker()
    
    
    
    
    
    var delegate : AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        AddButoonOut.layer.cornerRadius = 50
    
        
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        DatePicker.preferredDatePickerStyle = .wheels
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        toolbar.setItems([doneButton], animated: false)
        DateTX.inputAccessoryView = toolbar
        DateTX.inputView = DatePicker
        
    }
    @objc func donedatePicker(){

     let formatter = DateFormatter()
     formatter.dateFormat = "dd/MM/yyyy"
        DateTX.text = formatter.string(from: DatePicker.date)
     self.view.endEditing(true)
   }
    
    
    
    @IBAction func AddButoon(_ sender: Any) {
        
    
        if NewTaskTF.text != ""{
            
            delegate?.addTask(name: NewTaskTF.text! , details: DescribeTX.text! , Date: DateTX.text!)
            
//            _ = navigationController?.popViewController(animated: true)

    UserDefaults.standard.set(try? PropertyListEncoder().encode(Tasks), forKey: "MyData")
            performSegue(withIdentifier: "taskAddedSegue", sender: nil)

            
        }

    }

}



