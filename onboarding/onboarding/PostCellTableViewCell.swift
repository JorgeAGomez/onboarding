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
  let myColor : UIColor = UIColor( red: 0, green: 122/255, blue:255/255, alpha: 1.0)
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func circleTapped(sender: AnyObject)
  {
    if(circleButton.backgroundColor == myColor){
      circleButton.backgroundColor = UIColor.whiteColor()
    }
    else{
      circleButton.backgroundColor = myColor
    }
  }
  
  @IBAction func squareTapped(sender: AnyObject)
  {
    if(squareButton.backgroundColor == myColor){
      squareButton.backgroundColor = UIColor.whiteColor()
    }
    else{
      squareButton.backgroundColor = myColor
    }
  }

}
