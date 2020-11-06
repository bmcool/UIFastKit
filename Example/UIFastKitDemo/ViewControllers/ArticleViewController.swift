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
    let description: String?
    let author: String?
    let email: String?
    let date: String?
    let categories: [String]
}

class ArticleViewModel {
    let slogan = BehaviorRelay<String?>(value: nil)
    let subtitle = BehaviorRelay<String?>(value: nil)
    let description = BehaviorRelay<String?>(value: nil)
    let author = BehaviorRelay<String?>(value: nil)
    let email = BehaviorRelay<String?>(value: nil)
    let date = BehaviorRelay<String?>(value: nil)
    let categories = BehaviorRelay<[String]>(value: [])

    var cellModels = [ArticleCellModel]()
    
    init() {
        cellModels = 50.list.map {_ in
            return ArticleCellModel(
                slogan: Lorem.words(1..<2),
                subtitle: Lorem.sentence,
                description: Lorem.paragraph,
                author: Lorem.fullName,
                email: Lorem.emailAddress,
                date: Lorem.word,
                categories: Int.random(in: 3..<15).list.map {_ in Lorem.words(1..<2)
            })
        }
    }
}

fileprivate let label = UIFastDefine<UILabel> {$0.color(.white).fontSize(12)}
fileprivate let subtitleLabel = UIFastDefine<UILabel>(label) {$0.color(.lightGray)}
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        
        rootFlexContainer.layout(.fitContainer).backgroundColor(.black).box.column.padding(15)
            .add(
                UIView().box.basic(40%)
                    .add(
                        UIView().box.row
                            .add(UILabel(titleLabel).text(viewModel.slogan))
                            .add(UILabel(subtitleLabel).text(viewModel.subtitle).box.left(10).shrink(1))
                    )
                    .add(
                        UIView().box.shrink(1).grow(1).top(bigMargin)
                            .add(
                                UILabel(label).numberOfLines(0).text(viewModel.description)
                            )
                    )
                    .add(
                        categoriesView.box.top(bigMargin).row.alignItems(.center).wrap(.wrap)
                            .add(UILabel(titleLabel).text("Categories:"))
                    )
                    .add(
                        UIView().box.row.top(bigMargin)
                            .add(UILabel(titleLabel).text(viewModel.author))
                            .add(UILabel(subtitleLabel).text(viewModel.email).box.left(margin))
                            .add(UIView().box.grow(1).shrink(1))
                            .add(UILabel(subtitleLabel).text(viewModel.date).box.left(margin))
                    )
            )
            .add(tableView.box.top(bigMargin).grow(1).shrink(1))
        
        viewModel.categories.bind {[unowned self] categories in
            categoriesView.removeSubviews(123).box
                .define { box in
                    categories.forEach { box.add(UILabel(categoryLabel).tag(123).text($0)) }
                }
        }
        .disposed(by: disposeBag)
        
        selectedCell(viewModel.cellModels[0])
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    func selectedCell(_ model: ArticleCellModel) {
        viewModel.slogan.accept("[\(model.slogan ?? "-")]")
        viewModel.subtitle.accept(model.subtitle)
        viewModel.description.accept(model.description)
        viewModel.categories.accept(model.categories)
        viewModel.author.accept(model.author)
        viewModel.email.accept(model.email)
        viewModel.date.accept(model.date)
        view.setNeedsLayout()
    }
}

extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: UITableViewCell.className)
        let model = viewModel.cellModels[indexPath.row]
        cell.textLabel?.text = "[\(model.slogan ?? "-")] \(model.subtitle ?? "-")"
        cell.detailTextLabel?.text = "categories: \(model.categories.count)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell(viewModel.cellModels[indexPath.row])
    }
}
