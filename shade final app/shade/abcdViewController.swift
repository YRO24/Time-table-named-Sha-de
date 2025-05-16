//
//  abcdViewController.swift
//  shade
//
//  Created by Yashraj Parag Ola on 19/04/25.
//

import UIKit

class abcdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }

    func setupBackground() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "sunset")
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
    }

    @IBAction func mondayButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTimeSlot", sender: "Monday")
    }

    @IBAction func tuesdayButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTimeSlot", sender: "Tuesday")
    }

    @IBAction func wednesdayButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTimeSlot", sender: "Wednesday")
    }

    @IBAction func thursdayButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTimeSlot", sender: "Thursday")
    }

    @IBAction func fridayButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTimeSlot", sender: "Friday")
    }

    @IBAction func saturdayButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTimeSlot", sender: "Saturday")
    }

    @IBAction func sundayButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToTimeSlot", sender: "Sunday")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTimeSlot",
           let timeSlotVC = segue.destination as? abcViewController,
           let selectedDay = sender as? String {
            timeSlotVC.selectedDay = selectedDay
        }
    }
}
