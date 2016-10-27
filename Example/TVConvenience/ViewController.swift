//
//  ViewController.swift
//  TVConvenience
//
//  Created by Evan Dutcher on 10/27/16.
//  Copyright © 2016 jgrandelli. All rights reserved.
//

import UIKit
import URBNConvenience

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let redView = UIView()
        let blueView = UIView()
        let greenView = UIView()
        let imageView = UIImageView()
        
        blueView.backgroundColor = .blue
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        
        view.addSubviewsWithNoConstraints(redView)
        view.addSubviewsWithNoConstraints(blueView)
        view.addSubviewsWithNoConstraints(greenView)
        
        let views = ["redView": redView, "blueView": blueView, "greenView": greenView]
        
        activateVFL(
            format: "V:|-[blueView(==redView)][greenView(==redView)][redView]-|",
            options: [.alignAllLeft, .alignAllRight],
            views: views
        )
        activateVFL(
            format: "H:|-[redView]-|",
            views: views
        )
        
        imageView.image = "core image supports qr codes".qrImage(foregroundColor: .purple, backgroundColor: .green, size: CGSize(width: 100.0, height: 100.0))
        greenView.addSubviewsWithNoConstraints(imageView)
        NSLayoutConstraint(item: greenView, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: greenView, attribute: .centerY, relatedBy: .equal, toItem: imageView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

