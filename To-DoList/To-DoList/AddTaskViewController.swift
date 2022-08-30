
import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleTask: UITextField!
    @IBOutlet weak var descriptionTask: UITextField!
    @IBOutlet weak var dateTask: UIDatePicker!
    @IBOutlet weak var viewBackgroundAdd: UIView!
    @IBOutlet weak var saveOutlet: UIButton!
    
    var addTitle:String?
    var addDescription:String?
    var addDate:Date?
    var isComplete: Bool?
    var taskIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveOutlet.layer.cornerRadius = 12
        viewBackgroundAdd.layer.cornerRadius = 20
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        addTitle = titleTask.text
        addDescription = descriptionTask.text
        addDate = dateTask.date
        
        if addTitle != ""{
            taskList.append(TaskStruct.init(title: addTitle!, description: addDescription!, date: addDate!, isComplete: false))
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
}
