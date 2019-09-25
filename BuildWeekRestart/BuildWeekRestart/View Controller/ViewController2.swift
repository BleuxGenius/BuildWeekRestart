//
//  ViewController2.swift
//  BuildWeekRestart
//
//  Created by Lambda_School_Loaner_167 on 9/25/19.
//  Copyright © 2019 Dani. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var selectedDate: Date?
    
    let datePicker: UIDatePicker = UIDatePicker()
    
    let categoryPicker: UIPickerView = UIPickerView()
    
    let inputChoices: [Category] = [.Holiday, .Birthday, .Anniversary, .Home, .Work, .Other]
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter
    }()
    
    var delegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTextField.inputView = categoryPicker
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged), for: UIControl.Event.valueChanged)
        datePicker.datePickerMode = .date
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController2.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBOutlet weak var saveButton: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    @objc func dateChanged() {
        dateTextField.text =  dateFormatter.string(from: datePicker.date)
        
        print("Date changed")
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let titleText = titleTextField.text,
            let categoryText = categoryTextField.text,
            let category = Category(rawValue: categoryText)
        else {
            return
        }
        let newEvent =
            Event(title: titleText, date: datePicker.date, category: category)
        delegate?.events.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
}

extension ViewController2: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return inputChoices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return inputChoices[row].rawValue
    }
}

extension ViewController2: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = inputChoices[row].rawValue
    }
}


