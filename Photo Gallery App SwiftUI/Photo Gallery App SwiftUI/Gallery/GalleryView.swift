//
//  GalleryView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 15/12/22.
//

import SwiftUI
class DataSource: Identifiable {
    var id: String
    var image: Image
    var title: String
    
    init() {
        self.id = UUID().uuidString
        self.image = Image("mock-image").resizable()
        self.title = "mock-image"
    }
}
struct GalleryView: View {
    var rowList: Array<GridItem> = []
    var datasource: Array<DataSource> = []
    @State private var showSheet = false
    
    init() {
        self.rowListConfigure()
        for _ in 0...100 {
            self.datasource.append(DataSource())
        }
    }
    
    var body: some View {
        VStack {
            Group {
                HStack {
                    Button(action: {}) {
                        Text("Back to Home")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20.0)
                    Spacer()
                    Image("swift-firebase")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minHeight: 0.0, maxHeight: 50.0)
                        .padding(.trailing, 20.0)
                }
                .background(Color("BackgroundColor"))
                .frame(height: 50.0)
            }
            ScrollView {
                LazyVGrid(columns: self.rowList, spacing: 10.0) {
                    ForEach(0...self.datasource.count, id: \.self) { item in
                        Button(action: {
                            print("Clique...")
                            self.showSheet.toggle()
                        }) {
                            self.datasource[0].image
                                .aspectRatio(contentMode: .fit)
                        }
                        .sheet(isPresented: $showSheet) {
                            GalleryDetailView()
                        }
                    }
                }
            }
            .padding(.horizontal, 10.0)
        }
    }
}
extension GalleryView {
    mutating func rowListConfigure() -> Void {
        for _ in 0...2 {
            self.rowList.append(GridItem(.flexible(minimum: 100.0), spacing: 5.0))
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
