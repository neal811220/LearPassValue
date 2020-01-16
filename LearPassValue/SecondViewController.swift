//
//  SecondViewController.swift
//  LearPassValue
//
//  Created by Neal on 2020/1/15.
//  Copyright © 2020 neal812220. All rights reserved.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    
    func upDateDataToFirst(_ secondViewController: SecondViewController, data: String, tapRow: Int)
    
    func crateDataToFirst(_ secondViewController: SecondViewController, data: String)
}

class SecondViewController: UIViewController {
    
    var indoFormFirst: String?
    
    var currentTapRow: Int?
    
    weak var delegate: SecondViewControllerDelegate?
    
    var upDateDataToFirst:((String, Int) -> Void)?
    
    var createDateToFirst: ((String) -> Void)?
    
    var inputTextField: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.gray.cgColor
        text.isEnabled = true
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
        
    var tapButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.backgroundColor = .blue
        but.setTitle("Submit", for: .normal)
        return but
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.text = indoFormFirst
        setInfo()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        inputTextField.text = indoFormFirst
    }
    
    func setInfo() {
        
        view.addSubview(inputTextField)
        
        view.addSubview(tapButton)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            inputTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 2 / 3),
            
            tapButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),
            tapButton.heightAnchor.constraint(equalToConstant: 40),
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
        
        tapButton.addTarget(self, action: #selector(passToFirstView), for: .touchUpInside)
    }
    
    @objc func passToFirstView() {
        
        guard let input = inputTextField.text else { return }
        
        guard currentTapRow != nil else {
            createDateToFirst?(input)
            delegate?.crateDataToFirst(self, data: input)
            navigationController?.popViewController(animated: true)
            return
        }
        
        upDateDataToFirst?(input, currentTapRow ?? 0)
        
        delegate?.upDateDataToFirst(self, data: input, tapRow: currentTapRow ?? 0)
        
        navigationController?.popViewController(animated: true)
    }
}
