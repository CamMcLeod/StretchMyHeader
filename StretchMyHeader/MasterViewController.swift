//
//  MasterViewController.swift
//  StretchMyHeader
//
//  Created by Cameron Mcleod on 2019-07-09.
//  Copyright © 2019 Cameron Mcleod. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    private let kTableHeaderHeight: CGFloat = 250.0
    private let kTableHeaderCutaway: CGFloat = 80.0
    var headerMaskLayer : CAShapeLayer!
    
    var detailViewController: DetailViewController? = nil
    var newsItems = [NewsItem]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem
        populateSampleNewsItems()
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets.init(top: kTableHeaderHeight, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        // set up view layer mask
        headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()
        
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
////                let object = objects[indexPath.row] as! NSDate
////                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
////                controller.detailItem = object
////                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
////                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell

        let newsItem = newsItems[indexPath.row]
        
        categoryCell.categoryLabel.text = newsItem.category.rawValue
        categoryCell.categoryLabel.textColor = newsItem.categoryColor()
        categoryCell.headlineLabel.text = newsItem.headline
        
        return categoryCell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    //MARK: Private Functions
    private func populateSampleNewsItems() {
        
        let news1 = NewsItem.init(category: .world, headline: "Climate change protests, divestments meet fossil fuels realities")
        let news2 = NewsItem.init(category: .europe, headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'")
        let news3 = NewsItem.init(category: .middleEast, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible")
        let news4 = NewsItem.init(category: .africa, headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim or so they think, lol what the heck is this three lines yet?")
        let news5 = NewsItem.init(category: .asiaPacific, headline: "Despite UN ruling, Japan seeks backing for whale hunting")
        let news6 = NewsItem.init(category: .americas, headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria")
        let news7 = NewsItem.init(category: .world, headline: "South Africa in $40 billion deal for Russian nuclear reactors")
        let news8 = NewsItem.init(category: .europe, headline: "'One million babies' created by EU student exchanges")
        
        newsItems += [news1,news2,news3,news4,news5,news6,news7,news8]
    }
    
    private func updateHeaderView() {
        var headerViewRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerViewRect.origin.y = tableView.contentOffset.y
            headerViewRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerViewRect
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: headerViewRect.width, y: 0.0))
        path.addLine(to: CGPoint(x: headerViewRect.width, y: headerViewRect.height))
        path.addLine(to: CGPoint(x: 0.0, y: headerViewRect.height - kTableHeaderCutaway))
        headerMaskLayer?.path = path.cgPath
    }

}

