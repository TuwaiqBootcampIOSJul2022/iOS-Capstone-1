//
//  vcViewController.swift
//  toDoList
//
//  Created by Ruba on 01/02/1444 AH.
//

import UIKit

class vcViewController: UIViewController {

    @IBOutlet weak var retButton: UIButton!
    @IBOutlet weak var retrieve: UILabel!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var labelShow: UILabel!
    @IBOutlet weak var showDate: UITextField!
    let userDB = UserDefaults.standard
    var date = UIDatePicker()
    var title1 = ""
    var currentItem =  UserDefaults.standard.stringArray(forKey: "items") ?? []
    override func viewDidLoad() {
        super.viewDidLoad()
        showDate.textAlignment = .center
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        showDate.text = formatter1.string(from: date.date)
        UserDefaults.standard.setValue(currentItem, forKey: "items")
        labelShow.text = title1
        saveButton.layer.cornerRadius = 8
        retButton.layer.cornerRadius = 8
    }
    
    @IBAction func saveDetails(_ sender: Any) {
        userDB.setValue(details.text, forKey: "name")
    }
    
    @IBAction func retrieveDetails(_ sender: Any) {
        let ret = userDB.object(forKey: "name")
        if let bringData = ret as? String{
            retrieve.text = bringData
            return
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
