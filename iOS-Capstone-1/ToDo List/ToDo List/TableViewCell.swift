//
//  TableViewCell.swift
//  ToDo List
//
//  Created by Kholoud Almutairi on 01/02/1444 AH.
//

import UIKit

protocol ChangeButton{
    
    func ChangeButton(checked: Bool, index: Int )
}



class TableViewCell: UITableViewCell {
    
    var delegate: ChangeButton?
    var index : Int?
    var tasks : [Task]?

    
    
    @IBOutlet weak var Tasklabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    @IBAction func checkBoxAction(_ sender: Any) {
        
        if tasks![index!].checked{
            
            delegate?.ChangeButton(checked: false, index: index!)
            
        }else{
            
            delegate?.ChangeButton(checked: true, index: index!)

            
        }
        
        
    }
    
}
