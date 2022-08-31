//
//  ViewCell.swift
//  ListsToDo-App
//
//  Created by Hessa on 29/01/1444 AH.
//

import UIKit

class ViewCell: UITableViewCell {

  
    @IBOutlet weak var mydata: UILabel!
    @IBOutlet weak var leabl: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }
    
    func setupcell(titel: String, dste1: String){
        mydata.text = dste1
        leabl.text = titel
            
        }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func btn_box(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
//                if sender.isSelected {
//                   sender.isSelected = false
//                } else {
//                    sender.isSelected  = true
//                }
            }
}


