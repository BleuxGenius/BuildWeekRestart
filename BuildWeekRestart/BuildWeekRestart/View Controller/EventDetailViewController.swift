//
//  EventDetailViewController.swift
//  BuildWeekRestart
//
//  Created by Lambda_School_Loaner_167 on 9/25/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

        @IBOutlet var eventName: UILabel!
        @IBOutlet var eventDate: UILabel!
        @IBAction func cancelPressed(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
        
        var event: Event?
        
        func configure(with event: Event) {
            self.event = event
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            eventName.text = event?.title
            eventName.textColor = event?.category.colour()
            eventDate.text = event?.dateString()
            
            self.title = event?.title
        }
    }
