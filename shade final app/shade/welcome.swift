//
//  loginViewController.swift
//  shade
//
//  Created by Yashraj Parag Ola on 20/04/25.
//

import UIKit

class welcome: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView = UIImageView(frame: view.bounds)
           backgroundImageView.image = UIImage(named: "wlcm") // Replace "background" with the name of your image in Assets.xcassets
           backgroundImageView.contentMode = .scaleAspectFill // Or other content modes like .scaleToFill, .scaleAspectFit
        view.insertSubview(backgroundImageView, at: 0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
