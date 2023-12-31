//
//  ApplicationButton.swift
//  mobile
//
//  Created by cb on 08.09.23.
//

import SwiftUI

struct ApplicationButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color("FgColor"), lineWidth: 5)
            .frame(height: 60)
            .foregroundColor(Color("FeedBgColor"))
            .border(Color("FgColor"), width: 3)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 60)
                    .foregroundColor(Color("SuccessColor"))
                    .border(Color("FgColor"), width: 3)
                    .padding(.horizontal, 10.0)
                    .overlay(
                        Text("APPLY")
                            .font(.title)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                            .padding()
                    )
            )
    }
}

struct ApplicationButton_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationButton()
    }
}
