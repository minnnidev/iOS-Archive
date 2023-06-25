//
//  ViewController.swift
//  UIRefreshControl
//
//  Created by 김민 on 2023/06/25.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {

    // MARK: - UI Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()

    // MARK: - Properties

    var names = ["김", "이", "박"]

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundColor()
        setLayout()
        configureRefreshControl()
    }
}

extension ViewController {

    // MARK: - Custom Methods

    private func setBackgroundColor() {
        view.backgroundColor = .white
    }

    private func setLayout() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self,
                                            action: #selector(handleRefreshControl),
                                            for: .valueChanged)
    }

    // MARK: - @objc Methods

    @objc private func handleRefreshControl() {
        names.append("새고")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // delay 2초
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.setDataBind(names[indexPath.row])
        return cell
    }
}
