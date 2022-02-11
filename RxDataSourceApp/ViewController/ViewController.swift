//
//  ViewController.swift
//  RxDataSourceApp
//
//  Created by Motoki Onayama on 2022/02/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {

    var items = BehaviorRelay(value:
                                [SectionModel(header: "今季",
                                              items: [Anime(name: "明日ちゃんのセーラ服")])])
    
    let disposeBag = DisposeBag()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let cell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: {
        ds, tv, ip, item in
        let cell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip)
        cell.textLabel?.text = item.name
        cell.tintColor = .black
        return cell
    },
    titleForHeaderInSection: {
        ds, index in
        return ds.sectionModels[index].header
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        lauout()
        setupTableView()
    }
    
    func setupTableView() {
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    /// tableViewのレイアウトを調整
    func lauout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorColor = .black
        tableView.separatorInset = .zero
        let top = tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        let trailing = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let leading = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let bottom = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
    
}

