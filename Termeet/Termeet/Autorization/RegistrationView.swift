import SwiftUI

struct RegistrationView: View {
    var body: some View {
        VStack {
            VStack(spacing: 24) {

                Text("Termeet")
                    .font(.headline)
                    .padding(.top, 16)

                Text("Регистрация")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: 43, alignment: .leading)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Почта")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField("Введите почту", text: .constant(""))
                        .padding()
                        .frame(maxHeight: 44)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        

                        
                    Text("Для регистрации потребуется подтверждение почты")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }

            Spacer()

            VStack(spacing: 12) {

                Button {}
                label: {
                    Text("Подтвердить почту")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(maxHeight: 43)
                        .background(Color.gray)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                Button {}
                label: {
                    Text("Уже есть аккаунт?")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }

                HStack {
                    VStack {
                        Divider()
                    }
                    Text("или")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    VStack {
                        Divider()
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 10) {
                    Button {}
                    label: {
                        HStack {
                            Image(systemName: "y.circle.fill") // Можете заменить кастомной иконкой
                                .foregroundColor(.red)
                            Text("Продолжить с помощью Яндекс")
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(height: 43)
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    Button {}
                    label: {
                        HStack {
                            Image(systemName: "g.circle.fill")
                                .foregroundColor(.green)
                            Text("Продолжить с помощью Google")
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(height: 43)
                        .background(Color.black)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 40)
            }.frame(maxHeight: 320)
        }
        .frame(maxHeight: .infinity)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
