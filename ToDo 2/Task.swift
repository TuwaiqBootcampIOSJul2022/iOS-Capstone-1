import UIKit

class Task: UIViewController {

    @IBOutlet var LabelTitel: UILabel!
    @IBOutlet var LabelDetails: UITextView!
    
    var viewTitle: String?
    var viewDetail:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelTitel.text = viewTitle
        LabelDetails.text = viewDetail
    }
    


}
