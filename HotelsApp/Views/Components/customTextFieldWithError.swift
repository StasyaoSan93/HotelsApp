//
//  customTextField.swift
//  HotelsApp
//
//  Created by Стас Ильиных on 19.12.2023.
//

import SwiftUI

struct customTextFieldWithError: View {
    let hintText: String
    let backColor: Bool
    @Binding var fieldText: String
    let fieldType: FieldType
    
    @State private var viewPhone: String = ""
    
    @FocusState private var isFocused: Bool
    @State private var isEmailValid: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            if !fieldText.isEmpty {
                HStack {
                    Text(hintText)
                    Spacer()
                }
                .font(.system(size: 12))
                .foregroundStyle(Color.theme.grayText)
            }
            
            switch fieldType {
            case .info:
                TextField(hintText, text: $fieldText)
                    .textFieldCustomHint(when: fieldText.isEmpty, placeholder: {
                        Text(hintText)
                            .font(.system(size: 17))
                            .foregroundStyle(Color.theme.grayText)
                    })
                    .font(.system(size: fieldText.isEmpty ? 17 : 16))
                    .disableAutocorrection(true)
            case .phone:
                ZStack {
                    TextField(hintText, text: $fieldText)
                        .focused($isFocused)
                        .opacity(0.0)
                    
                    Text(viewPhone.isEmpty ? hintText : viewPhone)
                        .font(.system(size: fieldText.isEmpty ? 17 : 16))
                        .foregroundStyle(fieldText.isEmpty ? Color.theme.grayText : Color.theme.blackText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onChange(of: fieldText, initial: false) { oldValue, newValue in
                            if newValue.count > 11 {
                                self.fieldText = oldValue
                            } else if newValue.count == 0 {
                                viewPhone = hintText
                            } else {
                                viewPhone = formatForPhone(with: "+* (***) ***-**-**", phone: fieldText)
                            }
                        }
                }
            case .email:
                TextField(hintText, text: $fieldText)
                    .textFieldCustomHint(when: fieldText.isEmpty, placeholder: {
                        Text(hintText)
                            .font(.system(size: 17))
                            .foregroundStyle(Color.theme.grayText)
                    })
                    .font(.system(size: fieldText.isEmpty ? 17 : 16))
                    .disableAutocorrection(true)
                    .focused($isFocused)
                    .onChange(of: isFocused) {
                        if (!isFocused && !fieldText.isEmpty) {
                            isEmailValid = isValidEmail(fieldText)
                        }
                    }
            }
        }
        .foregroundColor(Color.theme.blackText)
        .animation(.default, value: fieldText.isEmpty)
        .padding(.horizontal, 12)
        .frame(height: 52)
        .background(content: {
            switch fieldType {
            case .info, .phone:
                (!backColor && fieldText.isEmpty) ? Color.theme.empryTextColor.opacity(0.75) : Color.theme.backgroundForField
            case .email:
                !isEmailValid ? Color.theme.empryTextColor.opacity(0.75) : Color.theme.backgroundForField
            }
            
        })
        .cornerRadius(10)
        .onTapGesture {
            if fieldType == .phone {
                isFocused = true
                if fieldText.isEmpty {
                    fieldText = "7"
                }
            }
        }
        
    }
}

#Preview {
    customTextFieldWithError(hintText: "Phone number here...", backColor: true, fieldText: .constant(""), fieldType: .info)
}

extension customTextFieldWithError {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func formatForPhone(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask  {
            if ch == "*" &&  index < numbers.endIndex {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else if ch == "*" {
                result.append("*")
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
