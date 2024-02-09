//
//  ContentView.swift
//  iOS Developer Task
//
//  Created by Roman Sukhorukov on 22.01.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var model: RecipesViewModel
    @Environment(\.safeAreaInsets) var saInsets
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Recipe.entity(), sortDescriptors:[], animation: .default)
    var recipes: FetchedResults<Recipe>
    
    @Namespace var namespace
    
    let gradient = LinearGradient(colors: [Color.white, Color.white.opacity(0.1)], startPoint: .top, endPoint: .bottom)

    var body: some View {
        ZStack(alignment: .top) {
             
            GeometryReader() { geo in
                
                let gridItems: [GridItem] = .init(repeating: GridItem(.flexible(minimum: 160, maximum: 192)), count: Int(geo.size.width/160))
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: gridItems, spacing: 32) {
                        ForEach(recipes) { recipe in
                            RecipeItemView(item: recipe, animation: namespace)
                        }
                    }
                    .padding(.top, saInsets.top + 54)
                    .padding(.bottom, saInsets.bottom + 8)
                    
                }
            }
            .padding(.horizontal, 16)
            
            ZStack(alignment: .bottom) {
                Color.white
                HStack() {
                    Text("Recipes")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.horizontal, 16)
                    Spacer()
                }
                .padding(.bottom, 12)
            }
            .frame(height: 46 + saInsets.top)
            
            if let recipe = model.selection {
                RecipeDetailView(recipe: recipe)
                    .matchedGeometryEffect(id: recipe.id, in: namespace)
            }
        }
        .ignoresSafeArea()
    }
}



#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        .environmentObject(RecipesViewModel())
}






