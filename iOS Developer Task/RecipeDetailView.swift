//
//  RecipeDetailView.swift
//  iOS Developer Task
//
//  Created by Владимир Костин on 09.02.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @EnvironmentObject var model: RecipesViewModel
    
    let recipe: Recipe
    
    let gradient = LinearGradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.0)], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        GeometryReader() { geo in
            let width = geo.size.width
            let height = geo.size.height
            ZStack() {
                Color.white
                if let imageId = recipe.imageId {
                    
                    Image(imageId.uuidString)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect((width + max(0, model.preferenceOffset))/width)
                        .position(x: 0.5*width, y: 0.5*(width + max(-200, model.preferenceOffset)))
                }
                gradient
                    .frame(width: width, height: width + max(0, model.preferenceOffset))
                    .position(x: 0.5*width, y: 0.5*(width + max(-200, model.preferenceOffset)))
                
                Text(recipe.name ?? "")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 17, weight: .semibold))
                    .position(x: 0.5*width, y: 72)
                Button(action: {
                    withAnimation(.spring()) {
                        model.selection = nil
                    }
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.white)
                        .frame(width: 18, height: 24)
                        .position(x: 18, y: 72)
                })
                
                ZStack(alignment: .top) {
                    Color.white
                        .cornerRadius(23, corners: [.topLeft, .topRight])
                    Capsule()
                        .frame(width: 36, height: 5)
                        .foregroundStyle(Color("LColor"))
                        .opacity(0.3)
                        .padding(.top, 8)
                }
                .frame(height: height)
                .position(x: 0.5*width, y: 0.9*height + max(-200, model.preferenceOffset))
                
                VStack(alignment: .center) {
                    
                        ScrollView(){
                            VStack(spacing: 0) {
                                 
                                Text("Cooking instruction:")
                                    .font(.system(size: 18, weight: .bold))
                                    .padding(.bottom, 16)
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack(){
                                        Text("Ingredients:")
                                            .font(.system(size: 16, weight: .semibold))
                                        Spacer()
                                    }
                                    Text(recipe.instructions ?? "")
                                        .font(.system(size: 16, weight: .medium))
                                    
                                }
                            }
                            .padding(.top, 0.24*height)
                            .background{
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .named("frameLayer")).minY )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .coordinateSpace(name: "frameLayer")
                        .onPreferenceChange(OffsetPreferenceKey.self) { value in
                            model.preferenceOffset = value
                        }
                    
                }
                .frame(height: 0.8*height)
                .clipped()
                .position(x: 0.5*width, y: 0.6*height)
            }
        }
        .ignoresSafeArea()
    }
}
