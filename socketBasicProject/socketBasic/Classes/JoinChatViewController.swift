//
//  JoinChatViewController.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//

import UIKit
import RealmSwift

class JoinChatViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func joinChatRoom() {
        
        let alertController = UIAlertController(title: "Socket", message: "Please enter a name:", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            
            guard let textFields = alertController.textFields else {
                return
            }
            
            let textfield = textFields[0]
            
            if textfield.text?.count == 0 {
                self.joinChatRoom()
            } else {
                
                guard let nickName = textfield.text else{
                    return
                }
                
                SocketHelper.shared.joinChatRoom(nickname: nickName) {
                    
//                    guard let nickName = textfield.text,
//                        let self = self else{
//                            return
//                    }
//                    self.moveToNextScreen(nickName)
                }
                self.moveToNextScreen(nickName)
            }
        }
        
        
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    private func moveToNextScreen(_ name: String) {
        
        let storyboard = UIStoryboard(name: "chat", bundle: nil)
        
        guard let chatListViewController = storyboard.instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController else{
            return
        }
        
        chatListViewController.nickName = name
        self.navigationController?.pushViewController(chatListViewController, animated: true)
    }
    
    @IBAction func btnJoinCLK(_ sender: UIButton) {
        joinChatRoom()
    }
}
