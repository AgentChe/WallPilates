//
//  ProfileEditViewController.swift
//  Soccer
//
//  Created by Виталий Загороднов on 29.04.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileEditViewController: UIViewController {
    
    private lazy var mainView = ProfileEditView()
    private lazy var viewModel = ProfileEditViewModel()
    
    init(skillLevel: SkillLevel?) {
        super.init(nibName: nil, bundle: nil)
        let content = ProfileEditSkillLevelView(skillLevel: skillLevel)
        content.didTapSave = { [weak self] in
            self?.viewModel.skillLevelRelay.accept($0)
        }
        self.mainView.setup(contentView: content)
    }
    
    init(weekSchedule: WeekSchedule?) {
        super.init(nibName: nil, bundle: nil)
        let content = ProfileEditDaysOfWeekView(weekSchedule: weekSchedule)
        content.didTapSave = { [weak self] in
            self?.viewModel.weekScheduleRelay.accept($0)
        }
        mainView.setup(contentView: content)
    }
    
    init(focusZones: [FocusZone], gender: Gender?) {
        super.init(nibName: nil, bundle: nil)
        let content = ProfileEditFocusZoneView(focusZones: focusZones, gender: gender)
        content.didTapSave = { [weak self] in
            self?.viewModel.focusZonesRelay.accept($0)
        }
        mainView.setup(contentView: content)
    }
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.tryAgain = { [weak self] error -> Observable<Void> in
            guard let self = self else {
                return .never()
            }
            
            return self.open(error: error)
        }
        
        Signal
            .merge(
                viewModel.saveResult,
                mainView.closeButton.rx.tap.asSignal()
            )
            .emit(with: self) { base, _ in
                base.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.activity
            .drive(Binder(self) { base, activity in
                base.activity(activity)
            })
            .disposed(by: disposeBag)
    }
}

private extension ProfileEditViewController {
    func open(error: Error) -> Observable<Void> {
        Observable<Void>
            .create { [weak self] observe in
                guard let self = self else {
                    return Disposables.create()
                }
                
                let vc = TryAgainViewController.make(error: error) {
                    observe.onNext(())
                }
                self.present(vc, animated: true)
                
                return Disposables.create()
            }
    }
    
    func activity(_ activity: Bool) {
        activity ? mainView.preloader.startAnimating() : mainView.preloader.stopAnimating()
    }
}

extension ProfileEditViewController {
    static func make(skillLevel: SkillLevel?) -> ProfileEditViewController {
        ProfileEditViewController(skillLevel: skillLevel)
    }
    
    static func make(weekSchedule: WeekSchedule?) -> ProfileEditViewController {
        ProfileEditViewController(weekSchedule: weekSchedule)
    }
    
    static func make(focusZones: [FocusZone], gender: Gender?) -> ProfileEditViewController {
        ProfileEditViewController(focusZones: focusZones, gender: gender)
    }
}
