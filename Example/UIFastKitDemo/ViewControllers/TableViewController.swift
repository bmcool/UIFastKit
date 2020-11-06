//
//  TableViewViewController.swift
//  UIFastKitDemo
//
//  Created by 林季正 on 2020/11/5.
//

import UIKit
import UIFastKit

class TableViewCell: UIFastTableViewCell {    
    let margin: CGFloat = 10
    
    var nameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        selectionStyle = .none
        separatorInset = .zero
        
        nameLabel.fontSize(14).lineBreakMode(.byTruncatingTail)        
        descriptionLabel.fontSize(12).numberOfLines(0)
        
        contentView.box.column.padding(12)
            .add(
                UIView().box.row
                    .add(UIView().backgroundColor(.gray).box.size(30))
                    .add(nameLabel.box.left(margin).grow(1))
            )
            .add(descriptionLabel.backgroundColor(.green).box.top(margin))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(_ model: TableViewCellModel) {
        nameLabel.text(model.name)
        descriptionLabel.text(model.description)
    }
}

struct TableViewCellModel {
    let name: String?
    let description: String?
}

class TableViewModel {
    var cellModels = [TableViewCellModel]()
    
    init() {
        cellModels = [
            TableViewCellModel(name: "direction(_: Direction)", description: "The direction property establishes the main-axis, thus defining the direction flex items are placed in the flex container container container."),
            TableViewCellModel(name: "wrap(_: Wrap)", description: "The `wrap` property controls whether the flex container is single-lined or multi-lined, and the direction of the cross-axis, which determines the direction in which the new lines are stacked in.\n\nBy default, the flex container fits all flex items into one line. Using this property we can change that. We can tell the container to lay out its items in single or multiple lines, and the direction the new lines are stacked in."),
            TableViewCellModel(name: "justifyContent(_: JustifyContent)", description: "The `justifyContent` property defines the alignment along the main-axis of the current line of the flex container. It helps distribute extra free space leftover when either all the flex items on a line have reached their maximum size. "),
            TableViewCellModel(name: "alignItems(_: AlignItems)", description: "The `alignItems` property defines how flex items are laid out along the cross axis on the current line. Similar to `justifyContent` but for the cross-axis (perpendicular to the main-axis)."),
            TableViewCellModel(name: "alignSelf(_: AlignSelf)", description: "The `alignSelf` property controls how a child aligns in the cross direction, overriding the `alignItems` of the parent. For example, if children are flowing vertically, `alignSelf` will control how the flex item will align horizontally.\n\n The \"auto\" value means use the flex container `alignItems` property. See `alignItems` for documentation of the other values."),
            TableViewCellModel(name: "alignContent(_: AlignContent)", description: "The align-content property aligns a flex container’s lines within the flex container when there is extra space in the cross-axis, similar to how justifyContent aligns individual items within the main-axis.\n\nNote, alignContent has no effect when the flexbox has only a single line."),
            TableViewCellModel(name: "layoutDirection(_: LayoutDirection)", description: "The layoutDirection property controls the flex container layout direction.\n\nValues:\n-`.inherit`\n  Direction defaults to Inherit on all nodes except the root which defaults to LTR. It is up to you to detect the user’s preferred direction (most platforms have a standard way of doing this) and setting this direction on the root of your layout tree.\n-.ltr: Layout views from left to right. (Default)\n-.rtl: Layout views from right to left.")
        ]
    }
}

class TableViewController: UIFastViewController {    
    let tableView = UITableView()
    
    let viewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.className)
        
        rootFlexContainer.layout(.fitContainer).box.column
            .add(UILabel().backgroundColor(.brown).color(.white).text("TableViewController Example").box.basic(60))
            .add(tableView.box.grow(1).shrink(1))
            
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: .default, reuseIdentifier: TableViewCell.className)

        cell.setModel(viewModel.cellModels[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
