//
//  InputStyleKit.swift
//
//
//  Created by Sheraz Ahmed on 18/03/2023.
//


import UIKit

@available(iOS 13.0, *)
@IBDesignable
public class InputStyleKit: UITextField {
    
    // MARK: - Private Properties
    
    
    private let floatingPlaceholder = UILabel()
    private let floatingView = UIView()
    private let pickerView = UIPickerView()
    
    private let errorIcon = UIImageView(image: UIImage(systemName: "exclamationmark.circle"))
    private let passwordIcon = UIImageView(image: UIImage(systemName: "eye.slash"))
    private let rightIconStackView = UIStackView()
    
    
    private var error: Bool = false {
        didSet {
            if error {
                errorIcon.isHidden = false
            } else {
                errorIcon.isHidden = true
            }
        }
    }
    
    // MARK: - Public Properties
    
    public var data: [String] = ["Option 1", "Option 2" ] {
        didSet {
            
            if data.count > 0 {
                self.text = data[0]
            }
            handleEditing()
            updatePickerData()
        }
    }
    
    
    
    
    
    public var selectedRow: Int? {
        get {
            return pickerView.selectedRow(inComponent: 0)
        }
        set {
            guard let row = newValue else {
                return
            }
            pickerView.selectRow(row, inComponent: 0, animated: true)
        }
    }
    
    
    

    
    // MARK: - Attribute Inspector
    
    @IBInspectable public var isFloatingPlaceHolder: Bool = false{
        didSet{
            setup()
        }
    }
    
    
    
    @IBInspectable public var leftIcon: UIImage? {
        didSet {
            setLeftTextfieldIcon()
        }
    }
    
    @IBInspectable public var IconTint: UIColor? {
        didSet {
            setLeftTextfieldIcon()
        }
    }
    
    
    
    @IBInspectable public var isPickerView: Bool = false{
        didSet{
            setup()
        }
    }
    
    
  
    
    
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    
    // MARK: - Private methods
    
    @objc private func setup() {
        
        
        delegate = self
        
        errorIcon.tintColor = UIColor.red
        errorIcon.isHidden = true
        
        rightIconStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        rightIconStackView.isLayoutMarginsRelativeArrangement = true
        rightIconStackView.spacing = 2
        rightIconStackView.addArrangedSubview(errorIcon)
        
        rightView = rightIconStackView
        rightViewMode = .always
        
        rightIconStackView.translatesAutoresizingMaskIntoConstraints = false
        rightIconStackView.leadingAnchor.constraint(equalTo: rightView!.leadingAnchor).isActive = true
        rightIconStackView.trailingAnchor.constraint(equalTo: rightView!.trailingAnchor).isActive = true
        
        
        
        if isFloatingPlaceHolder{
            setupFloatingPlaceHolder()
        }
        
        if isSecureTextEntry{
            enablePasswordToggle()
        }
        
        
        if isPickerView{
            
            setupPickerView()
        }
        
        
        
        let divider = UIView()
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.widthAnchor.constraint(equalToConstant: 0).isActive = true
        
        rightIconStackView.addArrangedSubview(divider)
        
        
    }
    

    
    
    
    
    @objc private func setupFloatingPlaceHolder() {
        
        floatingPlaceholder.font = font!.withSize(14)
        floatingPlaceholder.textColor = UIColor.placeholderText
        floatingPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        floatingPlaceholder.text = placeholder
        
        floatingView.backgroundColor = UIColor.systemBackground
        floatingView.translatesAutoresizingMaskIntoConstraints = false
        floatingView.alpha = 0
        addSubview(floatingView)
        floatingView.addSubview(floatingPlaceholder)
        
        
        
        NSLayoutConstraint.activate([
            
            floatingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            floatingView.topAnchor.constraint(equalTo: topAnchor, constant: -8),
            floatingView.heightAnchor.constraint(equalToConstant: 16),
            
            
            
            floatingPlaceholder.leadingAnchor.constraint(equalTo: floatingView.leadingAnchor, constant: 5),
            floatingPlaceholder.topAnchor.constraint(equalTo: floatingView.topAnchor),
            floatingPlaceholder.trailingAnchor.constraint(equalTo: floatingView.trailingAnchor, constant: -5),
            floatingPlaceholder.bottomAnchor.constraint(equalTo: floatingView.bottomAnchor)
        ])
        
        
        
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        addTarget(self, action: #selector(handleEditing), for: .editingChanged)
        handleEditing()
        
        
        
    }
    
    
    
    
    @objc private func enablePasswordToggle(){
        
        
        
        rightIconStackView.addArrangedSubview(passwordIcon)
        passwordIcon.tintColor = UIColor.placeholderText
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.togglePasswordView))
        passwordIcon.addGestureRecognizer(tap)
        passwordIcon.isUserInteractionEnabled = true
        
        
    }
    
    @objc private func setPasswordToggleImage() {
        if(isSecureTextEntry){
            passwordIcon.image = UIImage(systemName: "eye.slash")
            passwordIcon.tintColor = UIColor.placeholderText
        }else{
            passwordIcon.image = UIImage(systemName: "eye")
            passwordIcon.tintColor = UIColor.label
        }
    }
    
    @objc private func togglePasswordView() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage()
    }
    
    
    
    
    @objc private func setLeftTextfieldIcon(){
        if let image = leftIcon {
            let iconImageView = UIImageView(image: image)
            
            let iconSize = (font?.pointSize ?? 17) + 5
            iconImageView.frame = CGRect(x: 10, y: 0, width: iconSize, height: iconSize)
            
            iconImageView.tintColor = IconTint
            iconImageView.contentMode = .scaleAspectFit
            
            let iconView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + 10, height: iconSize))
            iconView.addSubview(iconImageView)
            
            leftView = iconView
            leftViewMode = .always
        } else {
            leftView = nil
            leftViewMode = .never
        }
    }
    
    
    
    
    @objc private func setupPickerView() {
        // Set up the picker view
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Set the input view of the text field to be the picker view
        self.inputView = pickerView
        
        if data.count > 0 {
            self.text = data[0]
        }
        handleEditing()
        
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Create a "Cancel" button
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPickerView))
        
        // Create a "Select" button
        let selectButton = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectPickerView))
        
        // Add the buttons to the toolbar
        toolbar.setItems([cancelButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), selectButton], animated: false)
        
        // Set the toolbar as the accessory view of the text field
        self.inputAccessoryView = toolbar
        
    }
    
    @objc private func cancelPickerView() {
        // Hide the picker view
        self.resignFirstResponder()
    }
    
    @objc private func selectPickerView() {
        // Update the text of the text field with the selected value from the picker view
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        if selectedRow >= 0 && selectedRow < data.count {
            self.text = data[selectedRow]
        }
        
        // Hide the picker view
        self.resignFirstResponder()
    }
    
    
    public func updatePickerData() {
        
        if isPickerView{
            // Reload the picker view data
            pickerView.reloadAllComponents()
        }
    }
    
    
    
    // MARK: - Public methods
    
    public func validateTextFields(_ textFields: [InputStyleKit]) -> Bool {
        var hasError = false
        
        for textField in textFields {
            if let text = textField.text, !text.isEmpty {
                // If the text field is not empty, clear any error state.
                textField.error = false
            } else {
                // If the text field is empty, apply an error state.
                textField.error = true
                hasError = true
            }
            
            if textField.textContentType == .emailAddress {
                if let text = textField.text, !text.isEmpty {
                    let emailRegex = RegexPatterns.pattern.emailPattern
                    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
                    
                    if !emailPredicate.evaluate(with: text) {
                        // If the text field is not a valid email, apply an error state.
                        textField.error = true
                        hasError = true
                    }
                }
            } else if textField.textContentType == .password || textField.textContentType == .newPassword {
                if let text = textField.text, !text.isEmpty {
                    let passwordRegex = RegexPatterns.pattern.passwordPattern
                    let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
                    
                    if !passwordPredicate.evaluate(with: text) {
                        // If the text field is not a valid password, apply an error state.
                        textField.error = true
                        hasError = true
                    }
                }
            }
        }
        
        return !hasError
    }
    
    
    
    
}


// MARK: - UITextFieldDelegate

@available(iOS 13.0, *)
extension InputStyleKit: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        handleEditing()
        return data[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.text = data[row]
        
    }
    
}

@available(iOS 13.0, *)
extension InputStyleKit: UITextFieldDelegate {
    
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        
        // Do something with the updated text
        if textContentType == .emailAddress{
            
            let emailRegex = RegexPatterns.pattern.emailPattern
            
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            
            if emailPredicate.evaluate(with: text) {
                error = false
            }
            else{
                error = true
            }
            
        }else if textContentType == .password || textContentType == .newPassword {
            
            let passwordRegex = RegexPatterns.pattern.passwordPattern
            
            let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
            
            
            if passwordPredicate.evaluate(with: text) {
                error = false
            }
            else{
                error = true
            }
            
        }
        else{
            error = false
        }
    }
    
    @objc private func handleEditing() {
        let shouldFloat = !(text?.isEmpty ?? true) && !(placeholder?.isEmpty ?? true)
        UIView.animate(withDuration: 0.2) {
            self.floatingView.alpha = shouldFloat ? 1 : 0
            self.layoutIfNeeded()
        }
    }
    
    
    
}
