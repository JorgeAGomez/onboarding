//
//  consentFirstScreenView.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-08-23.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit

@IBDesignable class consentFirstScreenView: UIView {
  
  var view :UIView!
  
  override init(frame: CGRect)
  {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(){
    view = loadViewFromNib()
    view.frame = bounds
    view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView{
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: "consentFirstScreenView", bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    return view
  }

}
