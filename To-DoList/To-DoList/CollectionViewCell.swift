
import UIKit
import M13Checkbox
protocol DataCollectionProtocol{
    func actionData(index: Int)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayNumberLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
    var delegate: DataCollectionProtocol?
    var index: IndexPath?
    var checkbox = M13Checkbox(frame: CGRect(x: -15.0, y: 0.0, width: 30.0, height: 30.0))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkbox.isEnabled = false
        checkbox.secondaryTintColor = .white
        checkbox.tintColor = .green
        checkbox.boxLineWidth = 2
        view.addSubview(checkbox)
    }
    
    @IBAction func optionButton(_ sender: Any) {
        delegate?.actionData(index: (index?.row)!)
    }
}

