import SwiftUI
import UserNotifications

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool
    var body: some View {
        TabView {
            OnboardingPageView(
                imageName: "leaf.circle",
                title: "Welcome to MoneyTree",
                subtitle: "Your personal finance assistant.",
                backgroundColor: .red, showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding
            )
            
            OnboardingPageView(
                imageName: "chart.bar",
                title: "Track Your Expenses",
                subtitle: "Easily log and view your spending.",
                backgroundColor: Color("Gold"), showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding
            )
            
            OnboardingPageView(
                imageName: "cursorarrow.rays",
                title: "Customise your Tree",
                subtitle: "Build the most beautiful tree.",
                backgroundColor: .blue, showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding
            )
            
            OnboardingPageView(
                imageName: "target",
                title: "Complete Quests",
                subtitle: "Achieve Stars to customise your tree.",
                backgroundColor: .orange, showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding
            )
            
            OnboardingPageView(
                imageName: "checkmark.circle",
                title: "Get Started Today",
                subtitle: "Your journey to better finances starts now.",
                backgroundColor: .green,
                showsDismissButton: true,
                shouldShowOnboarding: $shouldShowOnboarding
            )
        }
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
        .onAppear{
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]){ (succes, error) in
                if let error = error{
                    print("error: \(error)")
                }else{
                    print("success")
                }
            }
        }
    }
}

//#Preview {
//    OnboardingView()
//}

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let backgroundColor: Color
    let showsDismissButton: Bool
    @Binding var shouldShowOnboarding: Bool

    
    init(imageName: String, title: String, subtitle: String, backgroundColor: Color, showsDismissButton: Bool = false, shouldShowOnboarding: Binding<Bool>) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.backgroundColor = backgroundColor
        self.showsDismissButton = showsDismissButton
        self._shouldShowOnboarding = shouldShowOnboarding
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                if showsDismissButton {
                    Button(action: {
                        shouldShowOnboarding.toggle()
                    }) {
                        Text("Get Started")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.black)
                            .cornerRadius(6)
                            .padding(.top, 20)
                    }
                }
            }
        }
    }
}
