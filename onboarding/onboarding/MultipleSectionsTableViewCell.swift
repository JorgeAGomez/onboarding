//
//  MultipleSectionsTableViewCell.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-28.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class MultipleSectionsTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var circleButton: UIButton!
  @IBOutlet weak var squareButton: UIButton!
  let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  @IBAction func squareButton(_ sender: AnyObject)
  {
    if(squareButton.backgroundColor == myColor){
      squareButton.backgroundColor = UIColor.white
    }
    else{
      squareButton.backgroundColor = myColor
    }
  }
  
  @IBAction func circleButton(_ sender: AnyObject)
  {
      if(circleButton.backgroundColor == myColor){
      circleButton.backgroundColor = UIColor.white
    }
    else{
      circleButton.backgroundColor = myColor
    }
  }
  
}
