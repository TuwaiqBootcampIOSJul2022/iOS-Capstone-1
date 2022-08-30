//
//  ToDoCell.swift
//  capstoneFinal1
//
//  Created by AlenaziHazal on 03/02/1444 AH.
//

import UIKit
protocol ToDoDelegate : AnyObject{
    func checkMarkedTap(sender: ToDoCell)
    
}
class ToDoCell: UITableViewCell {
    weak var delegate : ToDoDelegate?
    @IBOutlet weak var dueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isComplatedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttenMarked(_ sender: UIButton) {
        delegate?.checkMarkedTap(sender: self)
    }
    
}
