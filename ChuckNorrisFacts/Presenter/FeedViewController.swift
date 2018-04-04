//
//  FeedViewController.swift
//  ChuckNorrisFacts
//
//  Created by Tatiana Magdalena on 14/03/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController: UIViewController, UITableViewDelegate {

    // MARK: UI Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var callToActionButton: UIButton!
    
    // MARK: Properties
    private var viewModel: FeedViewModel
    private let disposeBag = DisposeBag()
    private var currentState = Variable(FeedState.waitingForInput)
    
    // MARK: - Initializer -
    
    //
    // Alternativaly use the convenience initializer and delete the following two initializers.
    // By doing this way, the viewModel property must be optional. You can fix it by using:
    // ` private var viewModel: FeedViewModel! `
    //
    //convenience init(viewModel: FeedViewModel) {
    //        self.init()
    //        self.viewModel = viewModel
    //    }
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FeedViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 115
        tableView.register(UINib(nibName: FeedViewCell.identifier, bundle: nil), forCellReuseIdentifier: FeedViewCell.identifier)
        callToActionButton.setTitle("Pesquisar", for: .normal)
        
        visibilityBindings()
        textBinding()
        buttonActionBinding()
        bindTableViewDataSource()
    }
    
    // MARK: - Actions -
    
    func performCallToAction() {
        
        switch currentState.value {
        case .waitingForInput:
            search()
        case .error(let error):
            switch error {
            case .url:
                openSettings()
            case .client:
                search()
            default:
                break
            }
        default:
            break
        }
    }
    
    func search() {
        
        showAlert { [weak self] (term) in
            
            guard let thisVC = self else { return }
            
            let observable = thisVC.viewModel.getFactsList(searchTerm: term)
            
            observable
                .bind(to: thisVC.currentState)
                .disposed(by: thisVC.disposeBag)
            
            observable
                .subscribe(onNext: { [weak self] state in
                    var buttonTitle = ""
                    switch state {
                    case .waitingForInput:
                        buttonTitle = "Pesquisar"
                    case .error(let error):
                        switch error {
                        case .url:
                            buttonTitle = "Abrir Ajustes"
                        case .client:
                            buttonTitle = "Pesquisar"
                        default:
                            break
                        }
                    default:
                        break
                    }
                    self?.callToActionButton.setTitle(buttonTitle, for: .normal)
                })
                .disposed(by: thisVC.disposeBag)
        }
    }
    
    func openSettings() {
        guard let url = URL(string: UIApplicationOpenSettingsURLString),
            UIApplication.shared.canOpenURL(url)
            else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func showAlert(text: @escaping (String) -> ()) {
        let alertController = UIAlertController(title: "Pesquisa",
                                                message: "Entre com o termo a ser pesquisado",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: { _ in
                                                    if let textFields = alertController.textFields,
                                                        textFields.count > 0 {
                                                        text(textFields[0].text ?? "")
                                                    }
                                                    else {
                                                        text("")
                                                    }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField { (textField) in
            textField.placeholder = "Digite o termo"
        }
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Reactive bindings -

extension FeedViewController {
    
    func visibilityBindings() {
        currentState
            .asObservable()
            .map({ state in return state.isSuccess() })
            .bind(to: messageLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        currentState
            .asObservable()
            .map({ state in return state.isSuccess() })
            .bind(to: callToActionButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        currentState
            .asObservable()
            .map({ state in return !state.isSuccess() })
            .bind(to: tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        currentState
            .asObservable()
            .map({ state -> Bool in
                switch state {
                case .waitingForInput: return false
                case .loading: return true
                case .success: return true
                case .error(let error):
                    switch error {
                    case .client: return false
                    case .url: return false
                    default: return true
                    }
                }
            })
            .bind(to: callToActionButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func textBinding() {
        currentState
            .asObservable()
            .map({ state in return state.displayMessage })
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func buttonActionBinding() {
        callToActionButton
            .rx
            .tap
            .subscribe { [weak self] (_) in
                self?.performCallToAction()
            }
            .disposed(by: disposeBag)
    }
    
    func bindTableViewDataSource() {
        currentState
            .asObservable()
            .map({ (state) -> [FactOutput] in
                switch state {
                case .success(let facts): return facts
                default: return [FactOutput]()
                }
            })
            .bind(to: tableView.rx.items(cellIdentifier: FeedViewCell.identifier, cellType: FeedViewCell.self)) { (index, model, cell) in
                cell.phraseLabel.text = model.phrase
                cell.phraseLabel.font = UIFont.systemFont(ofSize: CGFloat(model.fontSize))
                cell.caterogyLabel.text = model.category
                cell.caterogyLabel.backgroundColor = UIColor(hexString: model.categoryColor.hexString)
            }
            .disposed(by: disposeBag)
    }
    
}
