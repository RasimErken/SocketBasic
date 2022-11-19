//
//  ChatDetailsTableView.swift
//  socketBasic
//
//  Created by rasim rifat erken on 18.10.2022.
//  Copyright © 2022 mac-0005. All rights reserved.
//


import UIKit
import RealmSwift

class ChatDetailsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var realmComingMessage = StoredMessage()
    
    var realMessages = [Message]()
    
    private var messageViewModel: MessageViewModel = MessageViewModel()
    var nickName: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configuartionTableView()
        configureViewModel()
        
    }
    
    private func configuartionTableView() {
        
        self.register(UINib(nibName: "MessageSendTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageSendTableViewCell")
        self.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTableViewCell")
        
        self.dataSource = self
        self.delegate = self
    }

    private func configureViewModel() {
        
        messageViewModel.arrMessage.subscribe { [weak self] (result: [Message]) in
            
            guard let self = self else {
                return
            }

            for i in result {
                if  i.nickname != self.nickName   {
                    self.realmComingMessage.nickname = self.nickName
                    self.realmComingMessage.message = i.message
                    self.realmComingMessage.date = i.date
                    self.realmComingMessage.senderNickname = i.nickname
                    
                    DBManager.sharedInstance.addData(object: self.realmComingMessage)
                }
            }
            
            let a = self.messageViewModel.arrMessage.value.last
            
            if a != nil {
                self.realMessages.append(a!)
            }
            
            self.reloadData()
            self.scrollToBottom(animated: false)
            
        }
        
        messageViewModel.getMessagesFromServer()
        
    }
}

// MARK: - Table view data source
extension ChatDetailsTableView {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = realMessages[indexPath.row]
        
        if message.nickname == nickName {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageSendTableViewCell") as? MessageSendTableViewCell else {
                return UITableView.emptyCell()
            }
            
            cell.configureCell(message)
            return cell
            
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as? MessageTableViewCell else {
            return UITableView.emptyCell()
        }
        
        cell.configureCell(message)
        return cell
   }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realMessages.count
    }
}

