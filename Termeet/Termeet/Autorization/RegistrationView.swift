import SwiftUI

private struct Constants {
    static let appName = "Termeet"
    static let titleText = "Регистрация"
    static let subTitleText = "Почта"
    static let placeholderText = "Введите почту"
    static let infoText = "Для регистрации потребуется подтверждение почты"
    static let footerText = "Уже есть аккаунт?"
    static let confirmButtonText = "Подтвердить почту"
    static let choiseText = "или"
    static let yandexImageName = "y.circle.fill"
    static let googleImageName = "g.circle.fill"
    static let yandexContinueText = "Продолжить с помощью Яндекс"
    static let googleContinueText = "Продолжить с помощью Google"
    
    static let registerStackSpacing: CGFloat = 24
    static let bodyStackSpacing: CGFloat = 12
    static let buttonStackSpacing: CGFloat = 10
    static let buttonHeight: CGFloat = 43
    static let cornerRadius: CGFloat = 10
    static let borederWidth: CGFloat = 1
    static let bottomPadding: CGFloat = 20
}

struct RegistrationView: View {
    var body: some View {
        VStack {
            VStack(spacing: Constants.registerStackSpacing) {

                Text(Constants.appName)
                    .font(.headline)

                Text(Constants.titleText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, maxHeight: Constants.buttonHeight, alignment: .leading)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: Constants.bodyStackSpacing) {
                    Text(Constants.subTitleText)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    TextField(Constants.placeholderText, text: .constant(""))
                        .padding()
                        .frame(maxHeight: Constants.buttonHeight)
                        .overlay(RoundedRectangle(cornerRadius: Constants.cornerRadius).stroke(Color.gray, lineWidth: Constants.borederWidth))


                        
                    Text(Constants.infoText)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }

            Spacer()

            VStack(spacing: Constants.bodyStackSpacing) {

                Button {}
                label: {
                    Text(Constants.confirmButtonText)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(maxHeight: Constants.buttonHeight)
                        .background(Color.gray)
                        .cornerRadius(Constants.cornerRadius)
                }
                .padding(.horizontal)
                Button {}
                label: {
                    Text(Constants.footerText)
                        .font(.footnote)
                        .foregroundColor(.blue)
                }

                HStack {
                    VStack {
                        Divider()
                    }
                    Text(Constants.choiseText)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    VStack {
                        Divider()
                    }
                }
                .padding(.horizontal)

                VStack(spacing: Constants.buttonStackSpacing) {
                    Button {}
                    label: {
                        HStack {
                            Image(systemName: Constants.yandexImageName)
                                .foregroundColor(.red)
                            Text(Constants.yandexContinueText)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(height: Constants.buttonHeight)
                        .background(Color.black)
                        .cornerRadius(Constants.cornerRadius)
                    }
                    .padding(.horizontal)

                    Button {}
                    label: {
                        HStack {
                            Image(systemName: Constants.googleImageName)
                                .foregroundColor(.green)
                            Text(Constants.googleContinueText)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(height: Constants.buttonHeight)
                        .background(Color.black)
                        .cornerRadius(Constants.cornerRadius)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, Constants.bottomPadding)
        }
        .frame(maxHeight: .infinity)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
