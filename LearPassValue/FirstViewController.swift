//
//  ViewController.swift
//  LearPassValue
//
//  Created by Neal on 2020/1/15.
//  Copyright © 2020 neal812220. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var inputArray = ["0", "1", "2", "3"]
    
    var deleteRow = 0
    
    var tapCell: UITableViewCell?
    
    var secondData = ""
    
    var tapRow = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func segueToSecondView(_ sender: UIBarButtonItem) {
        guard let secondView = storyboard?.instantiateViewController(identifier: "SecondView") as? SecondViewController else { return }
//        secondView.delegate = self
        secondView.createDateToFirst = {
            self.inputArray.append($0)
            self.tableView.reloadData()
        }
        show(secondView, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PassValueTableViewCell else { return UITableViewCell() }
        
        cell.outPutLabel.text = String(inputArray[indexPath.row])
        
        cell.delegate = self
//        cell.passData = {_ in
//            self.inputArray.remove(at: indexPath.row)
//            self.tableView.reloadData()
//        }
//        cell.buttonStyle.tag = indexPath.row
//
//        cell.buttonStyle.addTarget(self, action: #selector(deleteData), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let secondView = storyboard?.instantiateViewController(identifier: "SecondView") as? SecondViewController else { return }
        
        secondView.currentTapRow = indexPath.row
        
        secondView.indoFormFirst = String(inputArray[indexPath.row])
        
        secondView.upDateDataToFirst = {(text, index) in
            self.tableView.reloadData()
            self.secondData = text
            self.tapRow = index
            self.inputArray[self.tapRow] = self.secondData
            self.tableView.reloadData()
        }
        secondView.delegate = self
        
        show(secondView, sender: nil)
        
    }
    
    @objc func deleteData(sender: UIButton) {
        
        let index = sender.tag
        
        inputArray.remove(at: index)
        
        tableView.reloadData()
    }
    
}

extension FirstViewController: PassValueTableViewCellDelegate {
    
    func passButtontag(_ passValueTableViewCell: PassValueTableViewCell, buttonTag: Int) {
        
        guard let indexPath = tableView.indexPath(for: passValueTableViewCell) else { return }
        
        inputArray.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
        
    }
    
}

extension FirstViewController: SecondViewControllerDelegate {
    
    func crateDataToFirst(_ secondViewController: SecondViewController, data: String) {
        self.inputArray.append(data)
        tableView.reloadData()
    }
    
    func upDateDataToFirst(_ secondViewController: SecondViewController, data: String, tapRow: Int) {
        
        self.inputArray[tapRow] = data
        
        tableView.reloadData()
    }
    
    
    
}
