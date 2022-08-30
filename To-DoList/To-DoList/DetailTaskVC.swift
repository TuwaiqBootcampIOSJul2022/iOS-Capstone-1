
import UIKit

class DetailTaskVC: UIViewController {

    @IBOutlet weak var titleVC: UILabel!
    @IBOutlet weak var dateVC: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var descriptionVC: UITextView!
    
    var titleTaskVc:String?
    var descriptionTaskVC:String?
    var dateTaskVc:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBackground.layer.cornerRadius = 20
        
        titleVC.text = titleTaskVc
        descriptionVC.text = descriptionTaskVC
        
        let date = dateTaskVc!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY, hh:mm a"
        dateVC.text = formatter.string(from: date)
    }
}
