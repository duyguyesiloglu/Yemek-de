//
//  GPT3ViewController.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 16.10.2023.
//

import UIKit

class GPT3ViewController: UIViewController {
    
    let gptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = .systemFont(ofSize: 24, weight: .regular)
        label.font = UIFont(name: "font", size: 24)
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true

        // İki satırlık metni ayarlayın
       // label.text = "Customer Care\nThat's as Delicious as\nthe Food"
       // label.font = UIFont(name: "font", size: 24) // Özel bir yazı tipi ve boyutu ekleyin

        //label.text = "Customer Care That's as Delicious as the Food"
        label.textAlignment = .center
        return label
        
    }()
    
    lazy var tableView: UITableView = {
        let table =  UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        table.delegate = self 
        table.dataSource = self
        table.separatorStyle = .none
        
        return table
        
        
    }()
    
    let promptTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 10
        textView.clipsToBounds = true
        textView.backgroundColor = .systemGray6
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.secondaryLabel.cgColor
        textView.returnKeyType = .done
        
        textView.font = .systemFont(ofSize: 18, weight: .regular)
        return textView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Connect to Customer Support", for: .normal)
        button.backgroundColor = UIColor(named: "wp")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        return button
    }()
    var chat = [String]()
    
    //let indicatorView = UIView()
    //let activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
      
        configureUI()
        
    }
    private func configureUI() {
        view.addSubview(gptLabel)
        view.addSubview(tableView)
        view.addSubview(promptTextView)
        view.addSubview(submitButton)
       /* view.addSubview(indicatorView)
        
        indicatorView.isHidden = true
        indicatorView.frame = view.bounds
        indicatorView.backgroundColor = .systemGray6
        indicatorView.alpha = 0.95
        
        indicatorView.addSubview(activityIndicator)
        activityIndicator.center = view.center */
        
        NSLayoutConstraint.activate([
            
            gptLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
           gptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          gptLabel.widthAnchor.constraint(equalToConstant: 300),
           gptLabel.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo:gptLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.heightAnchor.constraint(equalToConstant: 400),
            
            promptTextView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            promptTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptTextView.widthAnchor.constraint(equalToConstant: 350),
            promptTextView.heightAnchor.constraint(equalToConstant: 70),
            
            submitButton.topAnchor.constraint(equalTo: promptTextView.bottomAnchor, constant: 10),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 350),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func fetchGPTChatResponseFor(prompt: String) {
       // indicatorView.isHidden = false
       // activityIndicator.startAnimating()
        
        Task {
            do {
                var gptText = try await APIService().sendPromptToGPT(prompt: prompt)
                await MainActor.run {
                    chat.append(prompt)
                    chat.append(gptText.replacingOccurrences(of: "/n/n", with: ""))
                    tableView.reloadData()
                    tableView.scrollToRow(at: IndexPath(row: chat.count-1, section: 0), at: .bottom, animated: true)
                   // promptTextView.text = ""
                    
                    
                }
            } catch {
               //  indicatorView.isHidden = true
                // activityIndicator.stopAnimating()
                print("error")
                
            }
        }
    }
    
    @objc func didTapSubmit() {
        
        promptTextView.resignFirstResponder()
        
        if let promptText = promptTextView.text, promptText.count > 3 {
            fetchGPTChatResponseFor(prompt: promptText)
            promptTextView.text = ""
        } else {
            print("please check textfield")
        }
    }
    
    
}
extension GPT3ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
        cell.selectionStyle = .none
        
        let text =  chat[indexPath.row]
      
        if indexPath.row % 2 == 0 {
            cell.configure(text: text , isUser: true)
        } else {
            cell.configure(text: text , isUser: false)
        }
        
        return cell
    }
}
