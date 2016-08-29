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
  let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  @IBAction func circleButton(sender: AnyObject)
  {
    if(circleButton.backgroundColor == myColor){
      circleButton.backgroundColor = UIColor.whiteColor()
    }
    else{
      circleButton.backgroundColor = myColor
    }
  }
  
  @IBAction func squareButton(sender: AnyObject) {
  }
  
  

}
