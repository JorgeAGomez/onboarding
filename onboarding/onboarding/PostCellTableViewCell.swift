//
//  PostCellTableViewCell.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-25.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class PostCellTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
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
  @IBAction func circleTapped(sender: AnyObject) {
    print("CIRCLE TAPPED!!")
  }

  @IBAction func squareTapped(sender: AnyObject) {
    print("SQUARE TAPPED!!")
  }
}
