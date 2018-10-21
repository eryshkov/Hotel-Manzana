//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Evgeniy Ryshkov on 20/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var adultsNumberLabel: UILabel!
    @IBOutlet weak var childrenNumberLabel: UILabel!
    @IBOutlet weak var wifiCostLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var isWifiNeeded: UISwitch!
    
    
    let wifiCostPerDay = 10
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let roomTypeSelect = IndexPath(row: 0, section: 4)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        updateDateViews()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        wifiCostLabel.text = String(wifiCostPerDay)
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(60 * 60 * 24)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
        
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                return 216
            } else {return 0}
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                return 216
            } else {return 0}
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismissKeyboard()
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
        case (roomTypeSelect.section, roomTypeSelect.row):
            performSegue(withIdentifier: "RoomTypeSelect", sender: nil)
        default:
            isCheckOutDatePickerShown = false
            isCheckInDatePickerShown = false
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "RoomTypeSelect":
            let dvc = segue.destination as! RoomSelectTableViewController
            dvc.modalPresentationStyle = .popover
            
            let popOverDVC = dvc.popoverPresentationController
            popOverDVC?.delegate = self
            popOverDVC?.sourceView = self.roomTypeLabel
            popOverDVC?.sourceRect = CGRect(x: roomTypeLabel.bounds.midX, y: roomTypeLabel.bounds.minY, width: 0, height: 0)
        default:
            break
        }
    }
    
    // MARK: - Navigation
    @IBAction func unwindToAddRegistrationVC(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? RoomSelectTableViewController {
            roomTypeLabel.text = sourceViewController.selectedRoom?.shortName
        }
        
    }
    
    // MARK: - IBActions
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = dateFormatter.string(from: checkInDatePicker.date)
        let checkOutDate = dateFormatter.string(from: checkOutDatePicker.date)
        let adultsNumber = adultsNumberLabel.text ?? ""
        let childrenNumber = childrenNumberLabel.text ?? ""
        let wifiCost = isWifiNeeded.isOn ? "$\(wifiCostPerDay) за день" : "Без Wi-Fi"
        let roomType = roomTypeLabel.text ?? ""
        
        let order = """
        Имя: \(firstName.isEmpty ? "Без имени" : firstName)
        Фамилия: \(lastName.isEmpty ? "Без фамилии" : lastName)
        email: \(email.isEmpty ? "Без e-mail" : email)
        Дата заезда: \(checkInDate)
        Дата выезда: \(checkOutDate)
        Количество взрослых: \(adultsNumber)
        Количество детей: \(childrenNumber)
        Wi-Fi: \(wifiCost)
        Категория номера: \(roomType.isEmpty ? "Не выбрана" : roomType)
        """
        
        let alertController = UIAlertController(title: "Ваш заказ", message: order, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(actionOK)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        if sender.tag == 100 {
            adultsNumberLabel.text = String(Int(sender.value))
        }
        
        if sender.tag == 200 {
            childrenNumberLabel.text = String(Int(sender.value))
        }
    }
    
}

extension AddRegistrationTableViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
