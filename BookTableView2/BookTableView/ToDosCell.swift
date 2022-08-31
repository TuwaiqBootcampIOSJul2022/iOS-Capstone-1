//
//  CustemCell.swift
//  BookTableView
//
//  Created by Kholoud Almutairi on 29/01/1444 AH.
//

import UIKit


class ToDosCell: UITableViewCell {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var labelTitel: UILabel!
    @IBOutlet weak var ckeakBouton: UIButton!
    //var index:Int?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // var cheak:Bool = false
    @IBAction func cheakBoutenAc(_ sender: Any) {
        
       
      
    }
}
