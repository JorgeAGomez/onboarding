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
  
  @IBAction func squareButton(sender: AnyObject)
  {
      if(squareButton.backgroundColor == myColor){
      squareButton.backgroundColor = UIColor.whiteColor()
    }
    else{
      squareButton.backgroundColor = myColor
    }
  }
  

}
