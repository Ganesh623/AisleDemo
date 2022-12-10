//
//  MainTabVC.swift
//  AisleDemo
//
//  Created by Ganesh N on 10/12/22.
//

import UIKit

class MainTabVC: UITabBarController {
    
    private var _authToken: String = ""
    
    init(authorization: String) {
        self._authToken = authorization
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        setupVCs()
    }
    
    private func setupVCs() {
        let homevc = HomeVC(homeVM: HomeViewModel(authToken: _authToken))
        let notesvc = NotesVC()
        let matchesvc = MatchesVC()
        let profilevc = ProfileVC()
        
        homevc.title = "Home"
        notesvc.title = "Notes"
        matchesvc.title = "Matches"
        profilevc.title = "Profile"
        
        self.setViewControllers([homevc, notesvc, matchesvc, profilevc], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let imgs = ["house", "envelope", "message", "person"]
        
        for i in 0..<4 {
            items[i].image = UIImage(systemName: imgs[i])
        }
        
        self.tabBar.tintColor = .darkGray
        self.tabBar.backgroundColor = .white
    }
}

// MARK: - Dummy Controllers -

class NotesVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightText
    }
}

class MatchesVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
    }
}

class ProfileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
    }
}
