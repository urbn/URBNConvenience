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
        let imageView = UIImageView()
        
        blueView.backgroundColor = .blueColor()
        redView.backgroundColor = .redColor()
        greenView.backgroundColor = .greenColor()

        view.addSubviewWithNoConstraints(redView)
        view.addSubviewWithNoConstraints(blueView)
        view.addSubviewWithNoConstraints(greenView)

        let views = ["redView": redView, "blueView": blueView, "greenView": greenView]
        
        activateVFL(
            format: "V:|-[blueView(==redView)][greenView(==redView)][redView]-|",
            options: [.AlignAllLeft, .AlignAllRight],
            views: views
        )
        activateVFL(
            format: "H:|-[redView]-|",
            views: views
        )
        
        imageView.image = qrImage(textToEncode: "core image supports qr codes", foregroundColor: .purpleColor(), backgroundColor: .greenColor(), size: CGSizeMake(100.0, 100.0))
        greenView.addSubviewWithNoConstraints(imageView)
        NSLayoutConstraint(item: greenView, attribute: .CenterX, relatedBy: .Equal, toItem: imageView, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: greenView, attribute: .CenterY, relatedBy: .Equal, toItem: imageView, attribute: .CenterY, multiplier: 1.0, constant: 0.0).active = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

