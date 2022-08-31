import UIKit

class AddOfTask: UIViewController{

    @IBOutlet var AddTitelTextFeld: UITextField!
    @IBOutlet var AdddetailsTextView: UITextView!
    @IBOutlet var AddDatePicker: UIDatePicker!
    
    var addNoteTitle:String?
    var addNotes:String?
    var addDatePicker:Date?
    let dateNew = Date.now
    var isComplet: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func button(_ sender: Any) {
        addNoteTitle = AddTitelTextFeld.text
        addNotes = AdddetailsTextView.text
        addDatePicker = AddDatePicker.date
     
        if addNoteTitle != ""{
            list.append(InformationToAddNote.init(noteTitle: addNoteTitle!, notes: addNotes!, datePicker: addDatePicker!, IsComplet: false))
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
