//
//  newViewController.swift
//  shade
//
//  Created by KJSCE on 08/04/25.
//

import UIKit


class abViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView = UIImageView(frame: view.bounds)
           backgroundImageView.image = UIImage(named: "what") // Replace "background" with the name of your image in Assets.xcassets
           backgroundImageView.contentMode = .scaleAspectFill // Or other content modes like .scaleToFill, .scaleAspectFit
        view.insertSubview(backgroundImageView, at: 0)

            
    }
}
