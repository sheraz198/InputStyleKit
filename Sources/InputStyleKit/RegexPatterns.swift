//
//  RegexPatterns.swift
//
//
//  Created by Sheraz Ahmed on 20/03/2023.
//

import Foundation


struct RegexPatterns {
    
    static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    
    static let password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d!@#\\$%\\^&\\*\\(\\)\\-_\\+=\\[\\]\\{\\}\\|;:\"<>,./\\?]{8,}$"
    
    /*
     The password pattern is broken down as follows:
     
     at least one lowercase letter (a-z)
     at least one uppercase letter (A-Z)
     at least one digit (0-9)
     Can include special characters such as !@#$%^&*()_-+=[ ]{}|;:\"<>,./? (but they are optional)
     
     A combination of uppercase letters, lowercase letters, digits and special characters with a minimum length of 8 characters
     */
    
}
