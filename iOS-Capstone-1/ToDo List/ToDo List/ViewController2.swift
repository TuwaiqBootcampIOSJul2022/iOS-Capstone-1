//
//  ViewController2.swift
//  ToDo List
//
//  Created by Kholoud Almutairi on 02/02/1444 AH.
//

import UIKit

class ViewController2: UIViewController {

    
    var TaskName = ""
    var Details : String?
    var dateTask : String = ""
    

  
    
    
    @IBOutlet weak var TaskeLabel2: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var DateLable2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TaskeLabel2.text = TaskName
        detailsLabel.text = Details
        DateLable2.text = dateTask 
                

                    
    }

}
