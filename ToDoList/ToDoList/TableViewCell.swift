//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Ahmed Salah on 28/08/2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var LaName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
