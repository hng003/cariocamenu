//
//  CariocaMenu+Protocols.swift
//  CariocaMenu
//
//  Created by Arnaud Schloune on 21/11/2017.
//  Copyright © 2017 CariocaMenu. All rights reserved.
//

import Foundation
import UIKit

typealias CariocaController = UITableViewController & CariocaDataSource

///DataSource protocol for filling up the menu
public protocol CariocaDataSource: UITableViewDataSource {
    func heightForRow() -> CGFloat
    func numberOfRows(_ tableView: UITableView) -> Int
}
extension CariocaDataSource {
    ///Default, only one section is allowed for now
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    ///Returns the number of rows
    func numberOfRows(_ tableViewItem: UITableView) -> Int {
        return tableView(tableViewItem, numberOfRowsInSection: 0)
    }
}

public protocol CariocaDelegate: class {
    func cariocaDidSelectItem(at index: Int)
}

///Delegate for UITableView events
class CariocaTableViewDelegate: NSObject, UITableViewDelegate {
    weak var delegate: CariocaDelegate?
    let rowHeight: CGFloat

    init(delegate: CariocaDelegate,
         rowHeight: CGFloat) {
        self.delegate = delegate
        self.rowHeight = rowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cariocaDidSelectItem(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}

extension CariocaTableViewDelegate {
    ///Default footer view (to hide extra separators)
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
}
