//
//  ChatDetailViewController.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//

import UIKit
import RealmSwift

class ChatDetailViewController: UIViewController {
    
    var realmMessage = StoredMessage()
    
    var realmComingMessage = StoredMessage()
    
    private var messageViewModel: MessageViewModel = MessageViewModel()
    
    var message = [Message]()

    @IBOutlet weak var tblChat: ChatDetailsTableView!  {
        didSet {
            
            guard let tblChat = tblChat else {
                return
            }
            
            tblChat.nickName = nickName
            tblChat.realMessages = message
        }
    }

    var user: User?
    var nickName: String?
    
    @IBOutlet weak var txtMessage: UITextView! {
        didSet {
            txtMessage.layer.cornerRadius = txtMessage.frame.height/2
            txtMessage.layer.borderWidth = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
       
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureNavigation() {
        
        guard let user = user else {
            return
        }
        
        title = user.nickname
    }
}

extension ChatDetailViewController {
    
    @IBAction func btnSendCLK(_ sender: UIButton) {
        
        guard txtMessage.text.count > 0,
            let message = txtMessage.text,
            let name = nickName else {
            print("Please type your message.")
            return
        }
        
        txtMessage.resignFirstResponder()
        
        SocketHelper.shared.sendMessage(message: message, withNickname: name) {
            print("Send Message")
        }
        realmMessage.nickname = user?.nickname
        realmMessage.message = message
        let myDate = Date()
        realmMessage.date = myDate.asString()
        realmMessage.senderNickname = nickName
        
        DBManager.sharedInstance.addData(object: self.realmMessage)
        self.txtMessage.text = nil
        
    }
    
}
