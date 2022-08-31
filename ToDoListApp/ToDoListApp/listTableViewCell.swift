//
//  listTableViewCell.swift
//  ToDoListApp
//
//  Created by Raneem Alkahtani on 29/08/2022.
//

import UIKit

protocol ListTabelViewCellDelegate: class {
    func checkBoxToggle(sender:listTableViewCell)
}
class listTableViewCell: UITableViewCell {


    weak var delegate: ListTabelViewCellDelegate?
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var cellDatelabel: UILabel!
    
    @IBOutlet weak var cellItemLabel: UILabel!
    @IBOutlet weak var indicationDate: UIImageView!
    
    
    @IBOutlet weak var indication: UIImageView!
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
}
