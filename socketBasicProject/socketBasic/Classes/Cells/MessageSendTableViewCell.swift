//
//  MessageSendTableViewCell.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//

import UIKit

class MessageSendTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var viewContainer: UIView!{
        didSet {
            viewContainer.layer.cornerRadius = 8.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ message: Message) {
        
        self.lblMessage.text = message.message ?? ""
        self.lblDate.text = message.date ?? ""
    }
}
