//
//  ArticleViewController.swift
//  UIFastKitDemo
//
//  Created by 林季正 on 2020/11/6.
//

import UIFastKit

struct ArticleCellModel {
    let slogan: String?
    let subtitle: String?
    let categories: [String]
}

class ArticleViewModel {
    let slogan = BehaviorRelay<String?>(value: nil)
    let subtitle = BehaviorRelay<String?>(value: nil)
    let categories = BehaviorRelay<[String]>(value: [])

    var cellModels = [ArticleCellModel]()
    
    init() {
        cellModels = [
            ArticleCellModel(slogan: "[Swift]", subtitle: "UIFastKit is the best layout system!!", categories: ["API", "UITableView", "Cache", "Model", "UILabel", "UIView", "Framework", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[Objective-C]", subtitle: "Yoga Good.", categories: ["API", "UITableView", "Cache", "Model", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[RxSwift]", subtitle: "Awesome!!!!!!!!!!!!!!", categories: ["API", "UITableView", "Model", "UILabel", "UIView", "Framework", "cocoapods", "BLKHJAL KAJjsdfksd"]),
            ArticleCellModel(slogan: "[Swift]", subtitle: "UIFastKit is the best layout system!!", categories: ["API", "UITableView", "Cache", "Model", "UILabel", "UIView", "Framework", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[Objective-C]", subtitle: "Yoga Good.", categories: ["API", "UILabel", "UIView", "Framework", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[RxSwift]", subtitle: "Awesome!!!!!!!!!!!!!!", categories: ["API", "UITableView", "Cache", "Model", "UILabel", "UIView", "Framework", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[Swift]", subtitle: "UIFastKit is the best layout system!!", categories: ["API", "Cache", "Model", "UILabel", "UIView", "Framework", "cocoapods", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[Objective-C]", subtitle: "Yoga Good.", categories: ["BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[RxSwift]", subtitle: "Awesome!!!!!!!!!!!!!!", categories: ["API", "UITableView", "Cache", "Model", "UILabel", "UIView", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh"]),
            ArticleCellModel(slogan: "[Swift]", subtitle: "UIFastKit is the best layout system!!", categories: ["API", "UITableView", "Cache", "Model", "UILabel", "UIView", "Framework", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[Objective-C]", subtitle: "Yoga Good.", categories: ["Framework", "cocoapods", "BLKHJAL KAJjsdfksd", "df jkdshajf hkjs afh", "dshf adsjfh"]),
            ArticleCellModel(slogan: "[RxSwift]", subtitle: "Awesome!!!!!!!!!!!!!!", categories: ["API", "UITableView", "Cache", "Model", "UILabel"]),
        ]
    }
}

fileprivate let label = UIFastDefine<UILabel> {$0.color(.white).fontSize(12)}
fileprivate let titleLabel = UIFastDefine<UILabel>(label) {$0.fontSize(14)}
fileprivate let categoryLabel = UIFastDefine<UILabel>(label) {
    $0.textAlign(.center).backgroundColor(.gray).fontSize(10).box.padding(5).bottom(5).left(10)
}

class ArticleViewController: UIFastViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    let categoriesView = UIView()
    
    let margin = CGFloat(10)
    let bigMargin = CGFloat(15)
    
    let viewModel = ArticleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        rootFlexContainer.layout(.fitContainer).backgroundColor(.black).box.column.padding(15)
            .add(
                UIView().box.row
                    .add(UILabel(label).text("2012"))
                    .add(UILabel(label).text("153 likes").box.left(margin))
                    .add(UILabel(label).text("Author: bmcool").box.left(margin))
            )
            .add(
                UIView().box.top(bigMargin).row
                    .add(UILabel(titleLabel).text(viewModel.slogan))
                    .add(UILabel(titleLabel).text(viewModel.subtitle).box.left(10))
            )
            .add(
                UILabel(label).numberOfLines(0).text("UIFastKit is the best layout system!! UIFastKit is the best layout system!! UIFastKit is the best layout system!! UIFastKit is the best layout system!! UIFastKit is the best layout system!! UIFastKit is the best layout system!! UIFastKit is the best layout system!!").box.top(bigMargin)
            )
            .add(
                UIView().box.top(bigMargin).minHeight(100).add(categoriesView)
            )
            .add(tableView.box.top(bigMargin).grow(1).shrink(1))
        
        viewModel.categories.bind {[unowned self] categories in
            categoriesView.subviews.forEach {$0.removeFromSuperview()}
            categoriesView.box.row.alignItems(.center).wrap(.wrap)
                .add(UILabel(titleLabel).text("Categories:"))
                .define { box in
                    categories.forEach { box.add(UILabel(categoryLabel).text($0)) }
                }
        }
        .disposed(by: disposeBag)
        
        selectedCell(viewModel.cellModels[0])
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    func selectedCell(_ model: ArticleCellModel) {
        viewModel.slogan.accept(model.slogan)
        viewModel.subtitle.accept(model.subtitle)
        viewModel.categories.accept(model.categories)
        view.setNeedsLayout()
    }
}

extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = viewModel.cellModels[indexPath.row]
        cell.textLabel?.text = "slogan: \(model.slogan ?? "-") - subtitle \(model.subtitle ?? "-")"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell(viewModel.cellModels[indexPath.row])
    }
}
