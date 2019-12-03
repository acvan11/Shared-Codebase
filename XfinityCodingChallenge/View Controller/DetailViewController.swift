//
//  DetailViewController.swift
//  XfinityCodingChallenge
//
//  Created by Franklin Mott on 11/19/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var nameLabel: UILabel!
    var descLabel: UILabel!
    var image: UIImageView!
    
    var character: CharacterModel! {
        willSet {
            DispatchQueue.main.async {
                self.image.image = nil
            }
        }
        didSet {
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }
    let session = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create UI
        nameLabel = UILabel(frame: .zero)
        nameLabel.textAlignment = .center
        descLabel = UILabel(frame: .zero)
        descLabel.numberOfLines = 0
        image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        view.addSubview(descLabel)
        view.addSubview(image)
        
        // setup constraints
        let const = [
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            nameLabel.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -16.0),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.bottomAnchor.constraint(equalTo: descLabel.topAnchor, constant: -16.0),
            image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
        ]
        NSLayoutConstraint.activate(const)
    }
    
    func setupUI() {
        guard let character = character else { return }
        nameLabel.text = character.name
        descLabel.text = character.desc
        
        func setDefaultImage() {
            let bundle = Bundle(for: DetailViewController.self)
            guard let image = UIImage(named: "peterporker", in: bundle, compatibleWith: nil) else { return }
            self.image.image = image
        }
        
        func setImage(_ imageData: Data? = nil) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    setDefaultImage()
                    return
                }
                guard let imageData = imageData else {
                    setDefaultImage()
                    return
                }
                let im = UIImage(data: imageData)
                self.image.image = im
            }
        }
        guard let url = URL(string: character.imageURL) else {
            setImage()
            return
        }
        session.dataTask(with: url) { (data, _, _) in
            setImage(data)
        }.resume()
    }

}
