//
//  SplitViewController.swift
//  SimpsonsCharacterViewer
//
//  Created by Franklin Mott on 11/20/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

// Protocol to simplify passing data from menu VC to the SplitViewController,
// to share with detail VC
protocol SelectCharacterProtocol: class {
    func didSelect(_ character: CharacterModel)
}

public class SplitViewController: UISplitViewController {

    var menuViewController: MainViewController!
    var detailViewController: DetailViewController!
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        // build our VCs
        setupViews()
        
        // setup splitViewController
        self.navigationItem.leftBarButtonItem = self.displayModeButtonItem
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func setupViews() {
        // build VCs
        menuViewController = MainViewController()
        menuViewController.delegate = self
        menuViewController.view.backgroundColor = .white
        detailViewController = DetailViewController()
        detailViewController.view.backgroundColor = .white
        
        // create navigation Controllers
        let primaryNav = UINavigationController(rootViewController: menuViewController)
        let secondaryNav = UINavigationController(rootViewController: detailViewController)
        
        // set as [master, detail]
        self.viewControllers = [primaryNav, secondaryNav]
    }
}

extension SplitViewController: UISplitViewControllerDelegate {
    // avoid default behavior to show detail-first
    public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension SplitViewController: SelectCharacterProtocol {
    func didSelect(_ character: CharacterModel) {
        detailViewController.character = character
        showDetailViewController(detailViewController, sender: nil)
    }
}
