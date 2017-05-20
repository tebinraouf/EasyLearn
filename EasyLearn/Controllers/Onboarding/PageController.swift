//
//  PageOneController.swift
//  EasyLearn
//
//  Created by Tebeen on 5/17/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    let cellID = "cellID"
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Easylearn"
        label.tintColor = .white
        label.textColor = .white
        label.backgroundColor = .clear
        label.font = UIFont(name: "PingFang SC", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var getStartedBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        //view.layer.ad
        return view
    }()
    var getStartedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("GET STARTED", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 20
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = .zero
        btn.layer.shadowOpacity = 0.5
        btn.layer.shouldRasterize = true //cache the shadow because it's expensive
        btn.addTarget(self, action: #selector(handleGetStarted), for: .touchDown)
        return btn
    }()
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = self.pages.count
        pc.currentPageIndicatorTintColor = .appColor
        return pc
    }()
    let pages: [Page] = {
        let firstPage = Page(title: "Word Definition", description: "Search for the most sophisticated word. Powered by Oxford Dictionaries.", image: #imageLiteral(resourceName: "search"))
        let secondPage = Page(title: "Custom Card", description: "Study words by using auto created cards and design your own cards.", image: #imageLiteral(resourceName: "card"))
        let thirdPage = Page(title: "Word Category", description: "Study words by categories. Choose from 200+ categories.", image: #imageLiteral(resourceName: "category"))
        return [firstPage, secondPage, thirdPage]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        registerCell()
        
    }
    func registerCell() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func viewDidLayoutSubviews() {
        setupView()
    }
    func handleGetStarted(){
        print(1234)
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
}


extension PageController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //var inset = collectionView.contentInset.
        
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PageController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
    }
    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension PageController {
    func setupView() {
        addViews()
        logoLabelViewSetup()
        collectionViewSetup()
        setupGetStartedBackground()
        setupPageControl()
        setupGetStartedButton()
    }
    func logoLabelViewSetup(){
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logoLabel.heightAnchor.constraint(equalTo: logoLabel.heightAnchor),
            logoLabel.widthAnchor.constraint(equalTo: logoLabel.widthAnchor),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    func collectionViewSetup(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
            ])
    }
    func setupGetStartedBackground(){
        NSLayoutConstraint.activate([
            getStartedBackground.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            getStartedBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            getStartedBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            getStartedBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    func setupGetStartedButton(){
        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor),
            getStartedButton.heightAnchor.constraint(equalTo: getStartedButton.heightAnchor),
            getStartedButton.widthAnchor.constraint(equalTo: getStartedButton.widthAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: getStartedBackground.bottomAnchor, constant: -20)
            ])
    }
    func setupPageControl(){
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: getStartedBackground.centerXAnchor),
            pageControl.heightAnchor.constraint(equalTo: pageControl.heightAnchor),
            pageControl.widthAnchor.constraint(equalTo: pageControl.widthAnchor),
            pageControl.topAnchor.constraint(equalTo: getStartedBackground.topAnchor, constant: 10)
            ])
    }
    func addViews(){
        view.addSubview(collectionView)
        view.addSubview(logoLabel)
        
        view.addSubview(getStartedBackground)
        view.addSubview(pageControl)
        view.addSubview(getStartedButton)
    }
    
}

class PageCell: BaseCell {
    var page: Page? {
        didSet {
            guard let page = page else { return }
            background.image = page.image
            titleLabel.text = page.title
            descriptionLabel.text = page.description
        }
    }
    var background: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        return iv
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Word Definition"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Word Description"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    var gradientLayer = CAGradientLayer()
    override func setupView() {
        setupGradientColor()
        addSubViews()
        backgroundSetup()
        titleSetup()
        descriptionSetup()
    }
    override func layoutSubviews() {
        setupView()
    }
    func addSubViews(){
        addSubview(background)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    func backgroundSetup(){
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: centerXAnchor),
            background.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    func titleSetup(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: background.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    //iPhone 6: top: 20, leading: 190
    //iPhone 5: top: 20, leading: 165
    func descriptionSetup(){
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)

            ])
    }
    func setupGradientColor() {
        layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor(r: 203, g: 45, b: 62, a: 1).cgColor, UIColor(r: 239, g: 71, b: 58, a: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
}

struct Page {
    var title: String
    var description: String
    var image: UIImage
}

/*
class BackgroundLayer<T: Numeric>: CAGradientLayer {
    
    let gradientLayer = CAGradientLayer()
    var width: T
    var height: T
    var x: T
    var y: T
    
    init(x: T, y: T, width: T, height: T) {
        self.width = width
        self.height = height
        setupGradientColor()
    }
    
    func setupGradientColor() {
        gradientLayer.colors = [UIColor(r: 203, g: 45, b: 62, a: 1).cgColor, UIColor(r: 239, g: 71, b: 58, a: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol Numeric {
    
}

extension CGFloat: Numeric {}
extension Int: Numeric {}
extension Float: Numeric {}
*/




