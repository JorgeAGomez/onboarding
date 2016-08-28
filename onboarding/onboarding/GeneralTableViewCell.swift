//
//  GeneralTableViewCell.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  
  @IBOutlet weak var circleButton: UIButton!
  
  @IBOutlet weak var squareButton: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  

}
