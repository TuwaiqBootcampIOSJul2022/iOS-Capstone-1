
import UIKit

class TaskViewController: UIViewController {


    @IBOutlet weak var label: UILabel!
    
    var task: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = task
        
    }
    

 
    }

