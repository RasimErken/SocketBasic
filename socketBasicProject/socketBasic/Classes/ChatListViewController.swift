//
//  ChatListViewController.swift
//  socketBasic
//
//  Created by rasim rifat erken on 06.10.2022.
//

import UIKit
import RealmSwift
import Combine

class ChatListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var observer : [AnyCancellable] = []
    
    var combineUser = [User]()
    
    var chatViewModel: ChatViewModel = ChatViewModel()
    
    
    var nickName: String?
    var nick = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        tableView.delegate = self
        tableView.dataSource = self
        configureViewModel()
        ActivityIndicator.sharedIndicator.showLoadingIndicator(onView: view)
        
        SocketHelper.shared.participantList { userList in
            print(userList)
        }
        

    }
    var subject = PassthroughSubject<String, Never>()
    
    private func configureViewModel() {
        
        guard let name = nickName else {
            return
        }
        
        chatViewModel.pass
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case.failure(let error):
                    print(error)
                }
            }, receiveValue: {[weak self] value in
                ActivityIndicator.sharedIndicator.hideLoadingIndicator()
                self?.combineUser = value
                self?.tableView.reloadData()
            }).store(in: &observer)

        chatViewModel.fetchParticipantList(name)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case.failure(let error):
                    print(error)
                }
            }, receiveValue: {[weak self] value in
                self?.combineUser = value
                self?.tableView.reloadData()
            }).store(in: &observer)
        
            
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension ChatListViewController {
    
    private func configuration() {
        
        guard let name = nickName else {
            return
        }
        
        title = "Welcome \(name)"

        navigationRightBarButton()
    }
    
    private func navigationRightBarButton() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Exit",
            style: .done,
            target: self,
            action: #selector(exitButtonCLK)
        )
    }
    
    
}

extension ChatListViewController {
    
    @objc func exitButtonCLK() {
        
        guard let name = nickName else {
            return
        }
        
        SocketHelper.shared.leaveChatRoom(nickname: name) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}

extension ChatListViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableView.emptyCell()
        }

        cell.textLabel?.text = combineUser[indexPath.row].nickname



        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        return chatViewModel.arrUsers.value.count
        return combineUser.count

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let board = UIStoryboard(name: "chat", bundle: nil)
        let detailsVC = board.instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController

        detailsVC.nickName = self.nickName

        detailsVC.user = combineUser[indexPath.row]
        
        var realmMessage = [StoredMessage]()

        let items = DBManager.sharedInstance.writeData()
        
        for item in items {
            if item.nickname == nickName || item.nickname ==  combineUser[indexPath.row].nickname!  {
                if item.senderNickname == nickName || item.senderNickname == combineUser[indexPath.row].nickname {
                    realmMessage.append(item)
                }
                
            }

        }
        
        var realMessage = [Message]()
        for i in realmMessage {
            var message : Message
            let senderNickname = i.senderNickname
            let message1 = i.message
            let date = i.date
            message = Message(date: date, message: message1, nickname: senderNickname)
            realMessage.append(message)

        }
        
        detailsVC.message = realMessage
        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}


