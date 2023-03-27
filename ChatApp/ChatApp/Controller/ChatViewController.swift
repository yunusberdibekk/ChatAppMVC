//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Yunus Emre Berdibek on 27.03.2023.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    //MARK: -PROPORTİES ChatReuseIdentifier
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    var msgArr = [Message]()
    
    //MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    private func initViews() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        let nib = UINib(nibName: "ChatCell", bundle: nil)
        messageTableView.register(nib, forCellReuseIdentifier: "ChatReuseIdentifier")
        messageTableView.delegate = self
        messageTableView.dataSource = self
        getMessages()
    }
    
    @IBAction func logoutClickedButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popViewController(animated: true)
        } catch  {
            debugPrint(error.localizedDescription)
        }
    }
    

    @IBAction func clickedBtnSend(_ sender: UIButton) {
        messageTF.endEditing(true)
        messageTF.isEnabled = false
        sendBtn.isEnabled = false
        
        let msgDB = Database.database().reference().child("Messages")
        let msDict = ["Sender": Auth.auth().currentUser?.email, "MessageBody":messageTF.text!]
        msgDB.childByAutoId().setValue(msDict, withCompletionBlock: { error, ref in
            
            if error != nil {
                debugPrint(error?.localizedDescription)
            } else{
                debugPrint("Message savaed successfully")
                self.messageTF.text = ""
                self.messageTF.isEnabled = true
                self.sendBtn.isEnabled = true
            }
            
        })
    }
    
    private func getMessages() {
        let msgDB = Database.database().reference().child("Messages")
        msgDB.observe(.childAdded, with: { snapShot in
            
            let value = snapShot.value as! Dictionary<String, String>
            let text = value["MessageBody"]!
            let sender = value["Sender"]!
            
            let msg = Message()
            msg.messageBody = text
            msg.sender = sender
            self.msgArr.append(msg)
            self.messageTableView.reloadData()
        })
    }
}

extension ChatViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // otomatik boyut
    }
    
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatReuseIdentifier") as! ChatTableViewCell
        cell.messageLbl.text = msgArr[indexPath.row].messageBody
        cell.usernameLbl.text = msgArr[indexPath.row].sender
        return cell
    }
    
    
}
