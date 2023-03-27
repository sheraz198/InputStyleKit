//
//  RegexPatterns.swift
//
//
//  Created by Sheraz Ahmed on 20/03/2023.
//

import Foundation



//struct RegexPatterns {
//
//    static let email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
//
//    static let password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d!@#\\$%\\^&\\*\\(\\)\\-_\\+=\\[\\]\\{\\}\\|;:\"<>,./\\?]{8,}$"
//
//    /*
//     The password pattern is broken down as follows:
//
//     at least one lowercase letter (a-z)
//     at least one uppercase letter (A-Z)
//     at least one digit (0-9)
//     Can include special characters such as !@#$%^&*()_-+=[ ]{}|;:\"<>,./? (but they are optional)
//
//     A combination of uppercase letters, lowercase letters, digits and special characters with a minimum length of 8 characters
//     */
//
//
//
//
//
//}



import Foundation



public class RegexPatterns {
    // Create a shared singleton instance
    public static let pattern = RegexPatterns()

    // Define regex patterns for email and password
    var emailPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    var passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d!@#\\$%\\^&\\*\\(\\)\\-_\\+=\\[\\]\\{\\}\\|;:\"<>,./\\?]{8,}$"

    /*
        The password pattern is broken down as follows:
   
        at least one lowercase letter (a-z)
        at least one uppercase letter (A-Z)
        at least one digit (0-9)
        Can include special characters such as !@#$%^&*()_-+=[ ]{}|;:\"<>,./? (but they are optional)
   
        A combination of uppercase letters, lowercase letters, digits and special characters with a minimum length of 8 characters
        */
   
    
    // Enum for regex pattern keys
    public enum PatternKey {
        case email
        case password
    }

    public func update(for key: PatternKey, with pattern: String) {
        // Check if the given pattern is valid
        guard let _ = try? NSRegularExpression(pattern: pattern, options: []) else {
            print("Invalid pattern for key \(key). Using default pattern.")
            return
        }
        
        // If valid, update the pattern for the given key
        switch key {
        case .email:
            emailPattern = pattern
        case .password:
            passwordPattern = pattern
        }
    }

    
}
