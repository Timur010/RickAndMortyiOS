//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by timur on 15.01.2023.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let req = RMRequest(endpoint: .character, pathComponents: ["1"], queryParameters: [
            URLQueryItem(name: "name", value: "Rick"),
            URLQueryItem(name: "status", value: "alive")
        ])
        print(req.url)
    }
}
