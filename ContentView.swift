//
//  ContentView.swift
//  QR Scanner
//
//  Created by Maurice Baumann on 1/20/22.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    
    @State private var isShowingScannerView = false
    @State private var gastro = "mt"
    @State private var table = "mt"
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text(gastro)
                    .padding()
                    .font(.headline)
                Text(table)
                    .padding()
                    .font(.subheadline)
                
                Spacer()
                Button {
                    isShowingScannerView = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
                .padding(10)
                Button {
                    self.gastro = "mt"
                    self.table = "mt"
                } label: {
                    Text("Reset")
                }
                Spacer()
            }
        }
        .navigationTitle("QR Scanner")
        .sheet(isPresented: $isShowingScannerView) {
            CodeScannerView(codeTypes: [.qr], completion: handleScan)
        }
    }
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScannerView = false
        
        switch result {
        case .success(let result):
            let detail = result.string.components(separatedBy: ";")
            guard detail.count == 2 else { return }
            
            self.gastro = detail[0]
            self.table = detail[1]
        case .failure(let error):
            print("ERROR: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
