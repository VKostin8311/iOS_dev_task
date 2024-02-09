//
//  RecipesViewModel.swift
//  iOS Developer Task
//
//  Created by Владимир Костин on 09.02.2024.
//

import SwiftUI

class RecipesViewModel: ObservableObject {
    
    @Published var selection: Recipe?
    @Published var preferenceOffset: CGFloat = 0

}
