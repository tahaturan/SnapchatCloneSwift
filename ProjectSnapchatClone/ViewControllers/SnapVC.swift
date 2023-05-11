//
//  SnapVC.swift
//  ProjectSnapchatClone
//
//  Created by Taha Turan on 11.05.2023.
//

import UIKit

class SnapVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var selectedSnap : SnapModel?
    var selectedTime : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        timeLabel.text = "Time Left: \(selectedTime ?? 0)"
    }
    



}
