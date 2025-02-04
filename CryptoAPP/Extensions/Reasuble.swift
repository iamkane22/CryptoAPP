import UIKit

class ReasubleButton: UIButton {
    
    var onAction: () -> Void
    
    init(title: String, color: UIColor, onAction: @escaping () -> Void) {
        self.onAction = onAction
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        backgroundColor = color
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func buttonAction() {
        onAction()
    }
}
