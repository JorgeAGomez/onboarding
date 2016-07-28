//
//  PostCellTableViewCell.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-25.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

class PostCellTableViewCell: UITableViewCell {

  @IBOutlet weak var squareSelectedImage: UIImageView!
  @IBOutlet weak var ovalSelectedImage: UIImageView!
  
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
      if(ovalSelectedImage.hidden)
      {
        ovalSelectedImage.hidden = false
        circleButton.hidden = true
      }
      else
      {
        ovalSelectedImage.hidden = true
        circleButton.hidden = false
      }
  }

  @IBAction func squareTapped(sender: AnyObject)
  {
      if(squareSelectedImage.hidden)
      {
        squareSelectedImage.hidden = false
        squareButton.hidden = true
      }
      else{
        squareSelectedImage.hidden = true
        squareButton.hidden = false
      }
  }
}
