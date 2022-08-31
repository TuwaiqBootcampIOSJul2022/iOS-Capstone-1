

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var currentDayLabel: UILabel!
    @IBOutlet var currentDateLabel: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    
}

struct currentDateNOW{
    
    var currentDateDay:Date
    var currentDay:Date
}
