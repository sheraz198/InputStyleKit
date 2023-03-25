# InputStyleKit


 [![Swift Version](https://img.shields.io/badge/swift-5.5-orange.svg)](https://swift.org/)
 [![SPM compatible](https://img.shields.io/badge/SPM-compatible-orange.svg)](https://swift.org/package-manager/)
 [![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

InputStyleKit is a powerful Swift package that provides a customizable textfield control with a range of useful features. With InputStyleKit, you can create textfields that support floating placeholders, left icons, password hiding, password validation, email validation, and even pickers.

![Demo GIF](https://raw.githubusercontent.com/sheraz198/InputStyleKit/main/ScreenShots/Demo.gif)

![WOW GIF](https://raw.githubusercontent.com/sheraz198/InputStyleKit/main/ScreenShots/Wow.gif)

# Installation

To use this package, you can include it in your project using Swift Package Manager.

### Swift Package Manager

1. Open Xcode and select "File" > "Swift Packages" > "Add Package Dependency"
2. Enter the repository URL
<blockquote style="background-color: #F5F5F5; padding: 10px;">
https://github.com/sheraz198/InputStyleKit.git
</blockquote>
3. Click "Next" and select the target where you want to add the package.
4. Click "Finish" to complete the installation.

### Manually

Drag the Sources folder anywhere in your project.

# Usage



The library can be easily integrated into your project. After setting your subclass to UITextField, all the IBDesignable settings will be available in the Attribute Inspector, providing a convenient way to customize your text fields within Interface Builder.

![Usage](https://raw.githubusercontent.com/sheraz198/InputStyleKit/main/ScreenShots/Usage.png)

### Use as Textfield
Customize the textfield using the IBInspectable properties available in the Attribute Inspector.

### Use as Picker
Create a UITextField subclass and set it to InputStyleKit:
<pre>

@IBOutlet weak var picker: InputStyleKit!

</pre>

Set the data property to an array of strings:
<pre>

picker.data = ["iOS", "Android", "Laravel", "Unity"]

</pre>

If you have a model object with a name property, you can use the map function to get an array of names:
<pre>

picker.data = modelArray.map { $0.name }

</pre>

To get the selected row index, you can use the selectedRow property:
<pre>

let selectedIndex = picker.selectedRow

</pre>


### Textfield Form Validation

To validate text fields in your form, you can use the validateTextFields function provided by InputStyleKit. This function will validate all of the text fields you pass as an array argument and return a Bool indicating whether all fields are not empty.

To ensure that a text field contains a valid email address, make sure that its content type is set to EmailAddress in Interface Builder.

To validate that a password text field contains at least one uppercase letter, one lowercase letter, one number, and is at least 8 characters long, make sure that its content type is set to Password in Interface Builder.


<pre>


let validation = InputStyleKit().validateTextFields([tfName, tfEmail, tfPassword])

// If all fields are valid, continue with your form submission or other action
if validation {
    // Perform form submission or other action here
} else {
    // Show an error message or other feedback to the user
}


</pre>


# Created By
Sheraz Ahmed, sheraz198@outlook.com


# License
InputStyleKit is available under the MIT license. See the LICENSE file for more info.
