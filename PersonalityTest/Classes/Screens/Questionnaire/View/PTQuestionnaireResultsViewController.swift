//
//  PTQuestionnaireResultsViewController.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTQuestionnaireResultsViewController: UIViewController {

    // MARK: Vars
    
    var results = [PTQuestionnaireResult]() {
        didSet {
            tableView?.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.estimatedRowHeight = 60
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    weak var coordinator: PTQuestionnaireResultsCoordinatorInterface!
    
    
    // MARK: Actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneAction))
        navigationItem.leftBarButtonItem = doneButton
    }
    
    @objc func doneAction() {
        coordinator.closeResults(sender: self)
    }
}

extension PTQuestionnaireResultsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = results[section]
        return category.results.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = results[section]
        return category.category
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if let resultCell = cell as? PTQuestionResultCell {
            let item = results[indexPath.section].results[indexPath.item]
            resultCell.questionLabel.text = item.question
            resultCell.answerLabel.text = item.answer
        }
        return cell!
    }
}


class PTQuestionResultCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
}
