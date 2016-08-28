//
//  ImmuneSystemTableViewCell.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-27.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class ImmuneSystemTableViewCell: UITableViewCell {

  @IBOutlet weak var circleButton: UIButton!
  @IBOutlet weak var squareButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
