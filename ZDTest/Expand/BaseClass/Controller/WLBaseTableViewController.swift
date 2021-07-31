//
//  WLBaseTableViewController.swift
//  ZDTest
//
//  Created by kede Han on 2020/12/23.
//

import UIKit

class WLBaseTableViewController: WLBaseViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView;
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func setup() {
        self.view.addSubview(tableView)
    }
}
