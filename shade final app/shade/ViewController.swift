import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var floatingImageView1: UIImageView!

    @IBOutlet weak var TITLE: UILabel!
    @IBOutlet weak var floatingImageView2: UIImageView!
    @IBOutlet weak var floatingImageView3: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TITLE.textColor = .white
        startFloatingAnimation(imageView: floatingImageView2)
        startFloatingAnimation(imageView: floatingImageView1)
        startFloatingAnimation(imageView: floatingImageView3)
        let backgroundImageView = UIImageView(frame: view.bounds)
           backgroundImageView.image = UIImage(named: "what") // Replace "background" with the name of your image in Assets.xcassets
           backgroundImageView.contentMode = .scaleAspectFill // Or other content modes like .scaleToFill, .scaleAspectFit
        view.insertSubview(backgroundImageView, at: 0)

    }
    @IBAction func unwind(segue:UIStoryboardSegue){}
    
    func startFloatingAnimation(imageView: UIImageView) {
        guard imageView != nil else {
            print("Error: imageView IBOutlet is not connected in the Storyboard!")
            return
        }
        
        func startFloatingAnimation(imageView: UIImageView) {
            guard imageView != nil else {
                print("Error: imageView IBOutlet is not connected in the Storyboard!")
                return
            }
            
            let horizontalOffset: CGFloat = 5.0
            let verticalOffset: CGFloat = 3.0
            let duration: TimeInterval = 2.0
            
            UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
                imageView.transform = CGAffineTransform(translationX: horizontalOffset, y: verticalOffset)
            }) { _ in
                UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .autoreverse], animations: {
                    imageView.transform = .identity
                })
            }
        }
    }
}
