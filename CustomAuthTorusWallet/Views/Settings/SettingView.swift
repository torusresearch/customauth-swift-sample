//
//  SettingView.swift
//  OpenLoginKeyViewer
//
//  Created by Dhruv Jaiswal on 07/11/22.
//

import SwiftUI

struct SettingView: View {
    @State var themeExpanded = false
    @State var networkExpanded = false
    @StateObject var vm: SettingVM
    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                SettingFormView(vm: vm, themeExpanded: $themeExpanded, networkExpanded: $networkExpanded)
                    .scrollContentBackground(.hidden)
                    .background(Color.bkgColor())
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.large)
            } else {
                SettingFormView(vm: vm, themeExpanded: $themeExpanded, networkExpanded: $networkExpanded)
                    .background(Color.bkgColor())
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.large)
                    .onAppear { // ADD THESE AFTER YOUR FORM VIEW
                        UITableView.appearance().backgroundColor = .clear
                    }
                    .onDisappear { // CHANGE BACK TO SYSTEM's DEFAULT
                        UITableView.appearance().backgroundColor = .systemGroupedBackground
                    }
            }

        }
    }
}
    struct SettingView_Previews: PreviewProvider {
        static var previews: some View {
            SettingView(vm: .init(blockchainManager: DummyBlockchainManager()))
            SettingFormView(vm: .init(blockchainManager: DummyBlockchainManager()), themeExpanded: .constant(false), networkExpanded: .constant(true))
        }
    }

    struct SettingFormView: View {
        @StateObject var vm: SettingVM
        @Binding var themeExpanded: Bool
        @Binding var networkExpanded: Bool
        var body: some View {
            Form {
                Section(header: Text("Networks")
                    .font(.custom(POPPINSFONTLIST.Regular, size: 14))) {
                    DisclosureGroup(isExpanded: $networkExpanded, content: {
                        List(BlockchainEnum.allCases) { val in
                            HStack {
                                Text(val.name)
                                    .font(.custom(POPPINSFONTLIST.Regular, size: 14))
                                Spacer()
                            }
                            .background(Color.whiteGrayColor())
                            .onTapGesture {
                                withAnimation {
                                    vm.changeBlockchain(val: val)
                                    networkExpanded = false
                                }
                            }

                        }
                        .listRowBackground(Color.whiteGrayColor())
                    }) {
                        Text(vm.blockchain.name)
                            .font(.custom(DMSANSFONTLIST.Regular, size: 16))
                    }
                }
                    .listRowBackground(Color.whiteGrayColor())
                Section(header: Text("Theme")
                    .font(.custom(POPPINSFONTLIST.Regular, size: 14))) {
                    DisclosureGroup(isExpanded: $themeExpanded, content: {
                        List(Theme.allCases) { val in
                            HStack {
                                Text(val.name)
                                    .font(.custom(POPPINSFONTLIST.Regular, size: 14))
                                Spacer()
                            }
                            .background(Color.whiteGrayColor())
                            .onTapGesture {
                                withAnimation {
                                    vm.changeTheme(val: val)
                                    themeExpanded = false
                                }
                            }

                        }
                        .listRowBackground(Color.whiteGrayColor())
                    }) {
                        Text(vm.getTheme.name)
                            .font(.custom(DMSANSFONTLIST.Regular, size: 16))
                    }
                }
                    .listRowBackground(Color.whiteGrayColor())
                Section {
                    Button {
                        vm.logout()
                    } label: {
                        Text("Logout")
                            .font(.custom(DMSANSFONTLIST.Regular, size: 16))
                            .foregroundColor(.red)
                    }
                }
                .listRowBackground(Color.whiteGrayColor())
            }
        }
    }
