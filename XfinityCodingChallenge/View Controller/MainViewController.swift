//
//  ViewController.swift
//  XfinityCodingChallenge
//
//  Created by Franklin Mott on 11/19/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

private let CELL_REUSE_ID = "CharacterTableCell"
private let CELL_HEIGHT: CGFloat = 85.0

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)
    
    weak var delegate: SelectCharacterProtocol?
    let viewModel: CharacterViewModelProtocol = CharacterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupSearchController()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    // MARK: Setup Methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupViewModel() {
        viewModel.get()
        viewModel.viewModelDelegate = self
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_REUSE_ID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        let const = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(const)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_ID, for: indexPath)
        let character = viewModel.characters[indexPath.row]
        cell.textLabel?.text = character.name
        return cell
   }
}
    
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            viewModel.filter(text)
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // talk to my split view
        let character = viewModel.characters[indexPath.row]
        self.delegate?.didSelect(character)
    }
}

extension MainViewController: CharacterViewModelDelegate {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
