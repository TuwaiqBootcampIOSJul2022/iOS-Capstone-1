

import UIKit

protocol ToDoCellDelgate: AnyObject {
    func checkmarkTapped(sender : TableViewCell)
}


class TableViewCell: UITableViewCell {
    weak var delegate : ToDoCellDelgate?

    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var secondDate: UILabel!
    @IBOutlet weak var secondCheck: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func secondCheckBtn(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
    }
    

}
