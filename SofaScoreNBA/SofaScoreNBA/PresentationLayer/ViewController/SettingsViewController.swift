//
//  SettingsViewController.swift
//  SofaScoreNBA
//
//  Created by Marko Andreis on 13.05.2022..
//

import UIKit

class SettingsViewController: UIViewController, UIScrollViewDelegate {
    
    let unitTypeRectangle = UIView()
    let matchDisplayRectangle = UIView()
    let aboutRectangle = UIView()
    
    let unitTypeLabel = UILabel()
    let matchDisplayLabel = UILabel()
    
    let metricRadioButton = RadioButton()
    let imperialRadioButton = RadioButton()
    
    let homeVisitorRadioButton = RadioButton()
    let visitorHomeRadioButton = RadioButton()
    
    let metricLabel = UILabel()
    let imperialLabel = UILabel()
    let homeVisitorLabel = UILabel()
    let visitorHomeLabel = UILabel()
    
    let aboutLabel = UILabel()
    let infoTextLabel = UILabel()
    let moreInfoButton = UIButton()
    
    let clearFavoritesButton = UIButton()
    
    lazy var scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.translatesAutoresizingMaskIntoConstraints = false
            scroll.delegate = self
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
            return scroll
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = view.safeAreaLayoutGuide
        scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
    }
    
    func configureUI() {
        scrollView.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 246/255, alpha: 1)
        configureRectangleSections()
        configureNavigationBar()
    }
    
    func configureRectangleSections() {
        configureUnitTypeSection()
        configureMatchDisplaySection()
        configureAboutSection()
        
        setRectangleSectionsConstraints()
        
        configureClearFavoritesButton()
    }
    
    func configureClearFavoritesButton() {
        clearFavoritesButton.layer.borderWidth = 1
        clearFavoritesButton.layer.borderColor = UIColor.red.cgColor
        clearFavoritesButton.setTitle("CLEAR MY FAVORITES LIST", for: .normal)
        clearFavoritesButton.setTitleColor(.systemRed, for: .normal)
        clearFavoritesButton.layer.cornerRadius = 5
        clearFavoritesButton.addTarget(self, action: #selector(clearFavoritesClicked), for: .touchUpInside)
        
        scrollView.addSubview(clearFavoritesButton)
        
        clearFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        clearFavoritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        clearFavoritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        clearFavoritesButton.topAnchor.constraint(equalTo: aboutRectangle.bottomAnchor, constant: 25).isActive = true
        clearFavoritesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func clearFavoritesClicked() {
        UserDefaultsManager.removePlayersAndTeamsRecords()
        let alert = UIAlertController(title: "Alert", message: "Favorite players and teams have been discarded.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureUnitTypeSection() {
        unitTypeRectangle.backgroundColor = UIColor(red: 212/255, green: 217/255, blue: 223/255, alpha: 0.4)
        unitTypeRectangle.layer.cornerRadius = 10
        scrollView.addSubview(unitTypeRectangle)
        
        unitTypeLabel.text = "UNIT TYPE"
        unitTypeLabel.font = unitTypeLabel.font.withSize(15)
        unitTypeLabel.textColor = .systemGray
        scrollView.addSubview(unitTypeLabel)
        
        unitTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        unitTypeLabel.topAnchor.constraint(equalTo: unitTypeRectangle.topAnchor, constant: 10).isActive = true
        unitTypeLabel.leadingAnchor.constraint(equalTo: unitTypeRectangle.leadingAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(metricRadioButton)
        metricRadioButton.translatesAutoresizingMaskIntoConstraints = false
        metricRadioButton.leadingAnchor.constraint(equalTo: unitTypeRectangle.leadingAnchor, constant: 20).isActive = true
        metricRadioButton.topAnchor.constraint(equalTo: unitTypeLabel.bottomAnchor, constant: 30).isActive = true
        metricRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        metricRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        metricRadioButton.switchSelected()
        metricRadioButton.addTarget(self, action: #selector(metricRadioButtonClicked(sender:)), for: .touchUpInside)
        
        scrollView.addSubview(imperialRadioButton)
        imperialRadioButton.translatesAutoresizingMaskIntoConstraints = false
        imperialRadioButton.leadingAnchor.constraint(equalTo: unitTypeRectangle.leadingAnchor, constant: 20).isActive = true
        imperialRadioButton.topAnchor.constraint(equalTo: metricRadioButton.bottomAnchor, constant: 20).isActive = true
        imperialRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imperialRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imperialRadioButton.addTarget(self, action: #selector(imperialRadioButtonClicked(sender:)), for: .touchUpInside)
        
        metricLabel.text = "Metric (cm, kg)"
        metricLabel.font = metricLabel.font.withSize(20)
        metricLabel.textColor = .black
        scrollView.addSubview(metricLabel)
        
        metricLabel.translatesAutoresizingMaskIntoConstraints = false
        metricLabel.leadingAnchor.constraint(equalTo: metricRadioButton.trailingAnchor, constant: 15).isActive = true
        metricLabel.centerYAnchor.constraint(equalTo: metricRadioButton.centerYAnchor).isActive = true
        
        imperialLabel.text = "Imperial (ft, lb)"
        imperialLabel.font = imperialLabel.font.withSize(20)
        imperialLabel.textColor = .black
        scrollView.addSubview(imperialLabel)
        
        imperialLabel.translatesAutoresizingMaskIntoConstraints = false
        imperialLabel.leadingAnchor.constraint(equalTo: imperialRadioButton.trailingAnchor, constant: 15).isActive = true
        imperialLabel.centerYAnchor.constraint(equalTo: imperialRadioButton.centerYAnchor).isActive = true
    }
    
    @objc func metricRadioButtonClicked(sender: RadioButton) {
        if sender.isChosen { return }
        sender.switchSelected()
        imperialRadioButton.switchSelected()
    }
    
    @objc func imperialRadioButtonClicked(sender: RadioButton) {
        if sender.isChosen { return }
        sender.switchSelected()
        metricRadioButton.switchSelected()
    }
    
    func configureMatchDisplaySection() {
        matchDisplayRectangle.backgroundColor = UIColor(red: 212/255, green: 217/255, blue: 223/255, alpha: 0.4)
        matchDisplayRectangle.layer.cornerRadius = 10
        scrollView.addSubview(matchDisplayRectangle)
        
        matchDisplayLabel.text = "MATCH DISPLAY"
        matchDisplayLabel.font = matchDisplayLabel.font.withSize(15)
        matchDisplayLabel.textColor = .systemGray
        scrollView.addSubview(matchDisplayLabel)
        
        matchDisplayLabel.translatesAutoresizingMaskIntoConstraints = false
        matchDisplayLabel.topAnchor.constraint(equalTo: matchDisplayRectangle.topAnchor, constant: 10).isActive = true
        matchDisplayLabel.leadingAnchor.constraint(equalTo: matchDisplayRectangle.leadingAnchor, constant: 20).isActive = true
        
        scrollView.addSubview(homeVisitorRadioButton)
        homeVisitorRadioButton.translatesAutoresizingMaskIntoConstraints = false
        homeVisitorRadioButton.leadingAnchor.constraint(equalTo: matchDisplayRectangle.leadingAnchor, constant: 20).isActive = true
        homeVisitorRadioButton.topAnchor.constraint(equalTo: matchDisplayLabel.bottomAnchor, constant: 30).isActive = true
        homeVisitorRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        homeVisitorRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        homeVisitorRadioButton.switchSelected()
        homeVisitorRadioButton.addTarget(self, action: #selector(homeVisitorRadioButtonClicked(sender:)), for: .touchUpInside)
        
        scrollView.addSubview(visitorHomeRadioButton)
        visitorHomeRadioButton.translatesAutoresizingMaskIntoConstraints = false
        visitorHomeRadioButton.leadingAnchor.constraint(equalTo: matchDisplayRectangle.leadingAnchor, constant: 20).isActive = true
        visitorHomeRadioButton.topAnchor.constraint(equalTo: homeVisitorRadioButton.bottomAnchor, constant: 20).isActive = true
        visitorHomeRadioButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        visitorHomeRadioButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        visitorHomeRadioButton.addTarget(self, action: #selector(visitorHomeRadioButtonClicked(sender:)), for: .touchUpInside)
        
        homeVisitorLabel.text = "Home vs Visitor"
        homeVisitorLabel.font = homeVisitorLabel.font.withSize(20)
        homeVisitorLabel.textColor = .black
        scrollView.addSubview(homeVisitorLabel)
        
        homeVisitorLabel.translatesAutoresizingMaskIntoConstraints = false
        homeVisitorLabel.leadingAnchor.constraint(equalTo: homeVisitorRadioButton.trailingAnchor, constant: 15).isActive = true
        homeVisitorLabel.centerYAnchor.constraint(equalTo: homeVisitorRadioButton.centerYAnchor).isActive = true
        
        visitorHomeLabel.text = "Visitor vs Home"
        visitorHomeLabel.font = visitorHomeLabel.font.withSize(20)
        visitorHomeLabel.textColor = .black
        scrollView.addSubview(visitorHomeLabel)
        
        visitorHomeLabel.translatesAutoresizingMaskIntoConstraints = false
        visitorHomeLabel.leadingAnchor.constraint(equalTo: visitorHomeRadioButton.trailingAnchor, constant: 15).isActive = true
        visitorHomeLabel.centerYAnchor.constraint(equalTo: visitorHomeRadioButton.centerYAnchor).isActive = true
    }
    
    @objc func homeVisitorRadioButtonClicked(sender: RadioButton) {
        if sender.isChosen { return }
        sender.switchSelected()
        visitorHomeRadioButton.switchSelected()
    }
    
    @objc func visitorHomeRadioButtonClicked(sender: RadioButton) {
        if sender.isChosen { return }
        sender.switchSelected()
        homeVisitorRadioButton.switchSelected()
    }
    
    func configureAboutSection() {
        aboutRectangle.backgroundColor = UIColor(red: 212/255, green: 217/255, blue: 223/255, alpha: 0.4)
        aboutRectangle.layer.cornerRadius = 10
        scrollView.addSubview(aboutRectangle)
        
        aboutLabel.text = "About"
        aboutLabel.textColor = .black
        aboutLabel.font = aboutLabel.font.withSize(25)
        view.addSubview(aboutLabel)
        
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.topAnchor.constraint(equalTo: aboutRectangle.topAnchor, constant: 10).isActive = true
        aboutLabel.leadingAnchor.constraint(equalTo: aboutRectangle.leadingAnchor, constant: 20).isActive = true
        
        infoTextLabel.text = "Volim sve što vole mladi, ali ja to malo bolje radim, ljubim ako mi se ljubi, a kad padne noć totalno poludim."
        infoTextLabel.numberOfLines = 0
        infoTextLabel.textColor = .black
        infoTextLabel.font = infoTextLabel.font.withSize(15)
        view.addSubview(infoTextLabel)
        
        infoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTextLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10).isActive = true
        infoTextLabel.leadingAnchor.constraint(equalTo: aboutRectangle.leadingAnchor, constant: 20).isActive = true
        infoTextLabel.trailingAnchor.constraint(equalTo: aboutRectangle.trailingAnchor, constant: -20).isActive = true
        
        moreInfoButton.setTitle("MORE INFO", for: .normal)
        moreInfoButton.setTitleColor(.systemBlue, for: .normal)
        view.addSubview(moreInfoButton)
        
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        moreInfoButton.leadingAnchor.constraint(equalTo: aboutRectangle.leadingAnchor, constant: 20).isActive = true
        moreInfoButton.bottomAnchor.constraint(equalTo: aboutRectangle.bottomAnchor, constant: -20).isActive = true
        
        
    }
    
    func setRectangleSectionsConstraints() {
        unitTypeRectangle.translatesAutoresizingMaskIntoConstraints                        = false
        unitTypeRectangle.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive           = true
        unitTypeRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive   = true
        unitTypeRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        unitTypeRectangle.heightAnchor.constraint(equalToConstant: 175).isActive     = true
        
        matchDisplayRectangle.translatesAutoresizingMaskIntoConstraints                        = false
        matchDisplayRectangle.topAnchor.constraint(equalTo: unitTypeRectangle.bottomAnchor, constant: 20).isActive           = true
        matchDisplayRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive   = true
        matchDisplayRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        matchDisplayRectangle.heightAnchor.constraint(equalToConstant: 175).isActive     = true
        
        aboutRectangle.translatesAutoresizingMaskIntoConstraints                        = false
        aboutRectangle.topAnchor.constraint(equalTo: matchDisplayRectangle.bottomAnchor, constant: 20).isActive           = true
        aboutRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive   = true
        aboutRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        aboutRectangle.heightAnchor.constraint(equalToConstant: 175).isActive     = true
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemBlue
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.red]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // navigationController?.navigationBar.barStyle = .black
        // navigationController?.navigationBar.tintColor = .white
        
        let logo = UIImage(named: "nba_logo.png")
        let imageView = UIImageView(image: logo)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        let favoritesLabel = UILabel()
        favoritesLabel.text = "Settings"
        favoritesLabel.textColor = .white
        self.navigationItem.titleView = favoritesLabel
        

    }


}
