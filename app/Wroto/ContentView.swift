import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var caption: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            Group {
                if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                    VStack {
                        Spacer()
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 6)
                        Spacer()

                    }
                        
                } else {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        VStack(alignment: .center) {
                            Spacer()
                            Image(systemName: "photo.badge.plus")
                            Text("Pick a photo")
                                .font(.headline)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                            Spacer()
                            HStack {
                                TextField("Enter a caption…", text: $caption)
                                        .textFieldStyle(.roundedBorder)
                                Button(action: {
                                    
                                }) {
                                    Text("Prompt")
                                }
                                Spacer()
                                VStack {
                                    Button(action: {
                                        
                                    }) {
                                        Text("Upload")
                                        Image(systemName: "photo.badge.plus")
                                    }
                                    
                                    Button(action: {
                                        
                                    }) {
                                        Text("Share")
                                    }
                                }
                            }
                        }
                    }
                    .onChange(of: selectedItem) { _, newItem in
                        guard let newItem else { return }
                        Task {
                            selectedImageData = try? await newItem.loadTransferable(type: Data.self)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
