//
//  PassValueTableViewCell.swift
//  LearPassValue
//
//  Created by Neal on 2020/1/15.
//  Copyright © 2020 neal812220. All rights reserved.
//

import UIKit

protocol PassValueTableViewCellDelegate: AnyObject{
    
    func passButtontag(_ passValueTableViewCell: PassValueTableViewCell, buttonTag: Int)
}

class PassValueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outPutLabel: UILabel!
    
    @IBOutlet weak var buttonStyle: UIButton!
    
    var passData: ((UITableViewCell) -> Void)?
    
    weak var delegate: PassValueTableViewCellDelegate?
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.passButtontag(self, buttonTag: sender.tag)
        passData?(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonStyle.layer.borderWidth = 1
        buttonStyle.layer.cornerRadius = 4
        buttonStyle.layer.borderColor = UIColor.red.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
