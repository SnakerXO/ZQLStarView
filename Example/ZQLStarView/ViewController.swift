//
//  ViewController.swift
//  ZQLStarView
//
//  Created by zangqilong on 04/01/2016.
//  Copyright (c) 2016 zangqilong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let starView = ZQLStarView(frame: CGRect(x: 100, y: 100, width: 100, height: 20), emptyStarImage: UIImage(named: "emptystar")!, fillStarImage: UIImage(named: "filledstar")!, count: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starView.minimCount = 1
        starView.maximaCount = 3
        starView.isHalfScoreModelOpen = false
        starView.callback = {
            score in
            print(score)
        }
        self.view.addSubview(starView);
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

