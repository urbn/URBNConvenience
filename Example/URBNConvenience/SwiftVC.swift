//
//  SwiftVC.swift
//  URBNConvenience
//
//  Created by Nick DiStefano on 12/11/15.
//  Copyright © 2015 jgrandelli. All rights reserved.
//

import UIKit
import URBNConvenience

class SwiftVC: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .whiteColor()
    }
    
    override func viewDidLoad() {
        let redView = UIView()
        let blueView = UIView()
        let greenView = UIView()

        blueView.backgroundColor = .blueColor()
        redView.backgroundColor = .redColor()
        greenView.backgroundColor = .greenColor()

        view.addSubviewWithNoConstraints(redView)
        view.addSubviewWithNoConstraints(blueView)
        view.addSubviewWithNoConstraints(greenView)

        let views = ["redView": redView, "blueView": blueView, "greenView": greenView]
        
        activateVFL(
            "V:|-[blueView(==redView)][greenView(==redView)][redView]-|",
            options: [.AlignAllLeft, .AlignAllRight],
            views: views
        )
        activateVFL(
            "H:|-[redView]-|",
            views: views
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

