//
//  ChatTableViewCell.swift
//  Yemek'De
//
//  Created by Duygu Yesiloglu on 16.10.2023.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    static let identifier = "ChatTableViewCell"
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        
        return label
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        
        return view
        
    }()
    
    var lead: NSLayoutConstraint!
    var trail: NSLayoutConstraint!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(bubbleView)
        bubbleView.addSubview(chatLabel)

        chatLabel.numberOfLines = 0
                chatLabel.lineBreakMode = .byWordWrapping
                chatLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true

                bubbleView.layer.cornerRadius = 10
        // Dikey (yükseklik) kısıtlamalarını kaldırın
        chatLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chatLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
            chatLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8),
            chatLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 8),
            chatLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -8),

            bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)

        ])

        lead = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        trail = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    }


    func configure(text: String, isUser: Bool) {
        chatLabel.text = text
        chatLabel.textColor = .black
        if isUser {
            bubbleView.backgroundColor = UIColor(named: "wp")
            lead.isActive = false
            trail.isActive = true
            
            
        } else {
            bubbleView.backgroundColor = .systemGray2
            lead.isActive = true
            trail.isActive = false
        }
    }
}
