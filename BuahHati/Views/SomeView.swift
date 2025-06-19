//
//  SomeView.swift
//  BuahHati
//
//  Created by Evan Lokajaya on 17/06/25.
//

import SwiftUI

struct SomeView: View {
    @State var ripeness: Ripeness
    
    var body: some View {
        Text(ripeness.rawValue)
    }
}

#Preview {
    SomeView(ripeness: .breaking)
}
