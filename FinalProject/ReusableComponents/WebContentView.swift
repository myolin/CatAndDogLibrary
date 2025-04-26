import SwiftUI
import WebKit

struct WebContentView: View {
    let webView = WebView()
    let url: String
    
    var body: some View {
        VStack {
            HStack {
                Button { // back button
                    webView.goBack()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                        .padding()
                } // back button
                Spacer()
                Text(url)
                    .font(Font.custom("Futura", size: 16))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Spacer()
                Button { // forward button
                    webView.goForward()
                } label: {
                    Image(systemName: "arrow.forward")
                        .font(.title)
                        .padding()
                } // forward button
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemBrown))
            
            webView // WebView
        }
        .onAppear() {
            webView.loadURL(urlString: url)
        }
        
    }
}

struct WebView: UIViewRepresentable {
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView()
    }
    
    func makeUIView(context: Context) -> some UIView {
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func goBack() {
        webView.goBack()
    }
    
    func goForward() {
        webView.goForward()
    }
    
    func loadURL(urlString: String) {
        webView.load(URLRequest(url: URL(string: urlString)!))
    }
}

#Preview {
    WebContentView(url: "https://www.google.com")
}

