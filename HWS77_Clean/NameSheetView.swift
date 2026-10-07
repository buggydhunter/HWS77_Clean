import SwiftUI

struct NameSheetView : View {
    @Environment(\.dismiss) var dismiss
    
    var person: Person
    var onSave: (Person) -> Void // The return envelope!
    
    @State private var typedName = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter person's name", text: $typedName)
            }
            .navigationTitle("New Contact")
            .toolbar {
                Button("Save") {
                    var finishedPerson = person
                    finishedPerson.name = typedName // Add the newly typed name
                    
                    onSave(finishedPerson) // Mail it back!
                    dismiss()
                }
            }
        }
    }
}
