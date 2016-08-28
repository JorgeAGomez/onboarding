//
//  ConsentFirstPageViewController.swift
//  onboarding
//
//  Created by Jorge Gomez on 2016-07-29.
//  Copyright © 2016 Jorge Gomez. All rights reserved.
//

import UIKit



class ConsentFirstPageViewController: UIViewController {

var pageControl = UIPageControl()

    override func viewDidLoad()
    {
      super.viewDidLoad()
      self.navigationItem.title = "Immune System / infection"
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
      var navBarSize = self.navigationController!.navigationBar.bounds.size
      var origin = CGPointMake(navBarSize.width / 2, navBarSize.height / 2)
      self.pageControl = UIPageControl(frame: CGRectMake(origin.x, origin.y+15, 0, 0))
      //Or whatever number of viewcontrollers you have
      self.pageControl.numberOfPages = 8
      self.pageControl.pageIndicatorTintColor = UIColor.redColor()
      self.pageControl.currentPageIndicatorTintColor = UIColor.blueColor()
      self.navigationController!.navigationBar.addSubview(self.pageControl)

    }
  
    func nextTapped()
    {
//      let controller = ConsentSecondPageViewController()
//      self.showViewController(controller, sender: self)
    }
  
  
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool)
    {
      let index = navigationController.viewControllers.indexOf(viewController)! - 7
      self.pageControl.currentPage = index
    }
}
