//
//  PasswordView.swift
//  Password
//
//  Created by Rodrigo Galeano on 26/10/25.
//

import SwiftUI

struct PasswordView: View {
    @StateObject private var viewModel = PasswordViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Password Game")
                .font(.title)
                .fontWeight(.bold)
            TextField("Choose a password", text: $viewModel.password)
                .frame(maxWidth: .infinity)
                .autocorrectionDisabled(true)
                .multilineTextAlignment(.center)
                .textInputAutocapitalization(.never)
            if viewModel.allCriteriaMet {
                Text("All criteria met 🎉")
                    .font(.headline)
                    .fontWeight(.semibold)
            } else if let message = viewModel.nextCriterionMessage {
                Label {
                    Text(message)
                        .font(.headline)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "x.circle.fill")
                        .foregroundStyle(.red)
                }
            }
        }
        .padding()
    }
}

#Preview {
    PasswordView()
}
