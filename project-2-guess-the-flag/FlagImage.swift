//
//  FlagImage.swift
//  project-2-guess-the-flag
//
//  Created by Luca Capriati on 2022/08/22.
//

import SwiftUI

// Project 4 - Challange 2

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "France")
    }
}
