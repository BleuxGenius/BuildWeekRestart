//
//  ViewController.swift
//  BuildWeekRestart
//
//  Created by Dani on 9/25/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

    class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

        @IBOutlet weak var tableView: UITableView!
        
        @IBOutlet weak var addNewButton: UIButton!
        
        var events: [Event] = [] {
            didSet {
                guard events.count > 0 else { return }
                // sort
                self.events.sort(by: {$0.date < $1.date})
                tableView.reloadData()
            }
        }
        
        var selectedEvent: Event?
        
        // @IBOutlet weak var eventCategoryLabel: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            let nib = UINib(nibName: "CountdownCell", bundle: nil)
            self.tableView.separatorColor = UIColor.white
            tableView.register(nib, forCellReuseIdentifier: "CountdownCellReuseIdentifier")
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = 70
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            if let viewControllerTwo = segue.destination as? ViewController2 {
                viewControllerTwo.delegate = self
            }
            
            if  let navigationController = segue.destination as? UINavigationController,
                let eventViewController = navigationController.viewControllers.first as? EventDetailViewController,
                let event = selectedEvent {
                eventViewController.configure(with: event)
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return events.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CountdownCellReuseIdentifier", for: indexPath) as! CountdownCell
            
            let event = events[indexPath.row]
            cell.configure(with: event)
            
                return cell
        }
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
                events.remove(at: indexPath.row)

            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedEvent = events[indexPath.row]
            performSegue(withIdentifier: "showEventDetail", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }

