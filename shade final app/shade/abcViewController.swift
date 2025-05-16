//
//  abcViewController.swift
//  shade
//
//  Created by Yashraj Parag Ola on 19/04/25.
//

import UIKit

class abcViewController: UIViewController {

    var selectedDay: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }

    func setupBackground() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "what2")
        backgroundImageView.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImageView, at: 0)
    }

    @IBAction func morningToNoonButtonTapped(_ sender: UIButton) {
        navigateToTodoList(withTimeSlot: "Morning to Noon")
    }

    @IBAction func afternoonToEveningButtonTapped(_ sender: UIButton) {
        navigateToTodoList(withTimeSlot: "Afternoon to Evening")
    }

    @IBAction func eveningToNightButtonTapped(_ sender: UIButton) {
        navigateToTodoList(withTimeSlot: "Evening to Night")
    }

    func navigateToTodoList(withTimeSlot timeSlot: String) {
        if let day = selectedDay {
            let dayAndTime = "\(day) - \(timeSlot)"
            performSegue(withIdentifier: "goToTodoList", sender: dayAndTime)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTodoList",
           let todoListVC = segue.destination as? TodoListViewController,
           let dayAndTime = sender as? String {
            todoListVC.dayAndTime = dayAndTime
        }
    }
}
