//
//  ViewController.swift
//  TableViewSectionHeader
//
//  Created by iMac on 2022/05/03.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var searchTitle: UILabel = {
        let label = UILabel()
        label.text = "종목검색"
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .label
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    private lazy var navigationView: UIView = {
        let view = UIView()
        [
            backButton,
            searchTitle
        ]
            .forEach {
                view.addSubview($0)
            }

        let inset: CGFloat = 16.0

        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(50.0)
            $0.bottom.equalToSuperview()
        }

        searchTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview()
        }

        return view
    }()

    private lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["국내", "해외"])
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false

        return tableView
    }()

    private let stocks: [String] = [
        "Alphabet",
        "Apple",
        "Amazon",
        "AMD",
        "ARKK ETF",
        "Game Stop",
        "Lucid",
        "Meta",
        "Miscrosoft",
        "Moderna",
        "Netflix",
        "Nvidia",
        "Palantir",
        "Paypal",
        "Pfizer",
        "QQQ ETF",
        "Rivian",
        "Roblox",
        "Sofi Tec",
        "SOXL ETF",
        "SPY ETF",
        "Tesla",
        "XLE ETF",
        "XLF ETF"
    ]

    lazy var sectionHeaders = Array(Set(stocks.map { $0.first! }).sorted())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(Set(stocks.map{ $0.first! })).count
    }

    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return String(Array(Set(stocks.map { $0.first! })).sorted()[section])
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let charactor = Array(Set(stocks.map{ $0.first! })).sorted()[section]
        return stocks.filter{ $0.first! == charactor }.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let charactor = Array(Set(stocks.map{ $0.first! })).sorted()[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = stocks.filter{ $0.first == charactor }[indexPath.row]
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        sectionForSectionIndexTitle title: String,
        at index: Int
    ) -> Int {
        print(title)
        guard let index = (sectionHeaders.firstIndex { String($0) == title }) else { return 0}

        return index
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return Array(Set(stocks.map{ String($0.first!) }).sorted())
    }
}

extension ViewController: UITableViewDelegate {

}

private extension ViewController {
    func setupViews() {
        [
            navigationView,
            segmentControl,
            tableView
        ]
            .forEach {
                view.addSubview($0)
            }

        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        segmentControl.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.height.equalTo(35.0)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
