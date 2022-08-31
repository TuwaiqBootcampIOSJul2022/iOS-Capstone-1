import UIKit


class TableViewCell: UITableViewCell {

    @IBOutlet var TitelNoteLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dateOfDayLabel: UILabel!
    @IBOutlet var StateLabel: UILabel!
    @IBOutlet var progess: UIView!
    
    
    @IBOutlet var ProgessBar: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
