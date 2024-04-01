//
//  ViewController.swift
//  TextFieldAndDatePicker
//
//  Created by 김민 on 4/1/24.
//

import UIKit

class ViewController: UIViewController {

    private let datePicker = UIDatePicker()
    private let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setLayout()
        setDatePicker()
        setPickerToolBar()
    }

    private func setLayout() {
        view.addSubview(textField)

        // textField 레이아웃 잡아주기
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    // datePicker 세팅
    private func setDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        textField.inputView = datePicker
    }

    // toolBbar 세팅
    private func setPickerToolBar() {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "done",
                                         style: .done,
                                         target: self,
                                         action: #selector(tappedDoneButton))
        let space = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.items = [space, doneButton]
        toolBar.sizeToFit()

        textField.inputAccessoryView = toolBar
    }

    // toolBar의 done 버튼 클릭 시의 action
    @objc private func tappedDoneButton() {
        textField.text = dateToString(datePicker.date)
        textField.resignFirstResponder()
    }

    // date -> String으로 변경하는 함수
    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}


