//
//  MainTabBarControler.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 13.05.2022..
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeTabBar()
        addTabTabItems()
    }
    
    private func customizeTabBar() {
        UITabBar.appearance().backgroundColor = .white
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemBlue], for: .selected)
        self.tabBar.tintColor = .systemRed
        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 5
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.cornerRadius = 10
    }
    
    private func addTabTabItems() {
        let exploreNav    = generateNavController(vc: ExploreViewController(), title: "EXPLORE")
        let favoritesNav  = generateNavController(vc: FavoritesViewController(), title: "FAVORITES")
        let seasonsNav    = generateNavController(vc: SeasonsViewController(), title: "SEASONS")
        let settingsNav   = generateNavController(vc: SettingsViewController(), title: "SETTINGS")
        
        viewControllers = [exploreNav, favoritesNav, seasonsNav, settingsNav]
    }
        
    fileprivate func generateNavController(vc: UIViewController, title: String) -> UINavigationController {
        vc.navigationItem.title = title
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        
        if title == "EXPLORE" {
            navController.tabBarItem.image = UIImage(systemName: "circle.fill")
        }
        else if title == "FAVORITES" {
            navController.tabBarItem.image = UIImage(systemName: "star.fill")
        }
        else if title == "SEASONS" {
            navController.tabBarItem.image = UIImage(systemName: "calendar")
        }
        else {
            navController.tabBarItem.image = UIImage(systemName: "gear")
        }
        
        return navController
    }
}
