//
//  ChatTableViewCell.swift
//  ChatApp
//
//  Created by Yunus Emre Berdibek on 27.03.2023.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    //MARK: -PROPORTİES
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var userIV: UIImageView!
    
    //MARK: -FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
