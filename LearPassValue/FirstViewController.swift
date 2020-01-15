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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func segueToSecondView(_ sender: UIBarButtonItem) {
        guard let secondView = storyboard?.instantiateViewController(identifier: "secondView") as? SecondViewController else { return }
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
        
        cell.outPutLabel.text = inputArray[indexPath.row]
        
        cell.passData = {_ in
            self.inputArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
