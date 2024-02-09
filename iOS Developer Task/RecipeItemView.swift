//
//  RecipeItemView.swift
//  iOS Developer Task
//
//  Created by Владимир Костин on 09.02.2024.
//

import SwiftUI

struct RecipeItemView: View {
    
    @EnvironmentObject var model: RecipesViewModel
    
    var item: Recipe
    var animation: Namespace.ID
    
    let gradient = LinearGradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack() {
            if let id = item.imageId {
                Image(id.uuidString)
                    .resizable()
            }
            if let name = item.name, model.selection == nil {
                ZStack(alignment: .bottom) {
                    gradient
                    Text(name)
                        .foregroundStyle(Color.white)
                        .font(.system(size: 12, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(15)
                }
                .onTapGesture {
                    withAnimation(.spring()) { model.selection = item }
                }
                .matchedGeometryEffect(id: item.id, in: animation)
            }
            
        }
        .frame(width: 160, height: 160)
        .clipShape(.rect(cornerRadius: 13))
    }
}
