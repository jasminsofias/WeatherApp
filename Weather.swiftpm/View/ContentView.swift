import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: [ResponseBody]? 
    
    var body: some View {
        VStack {
            if let location = locationManager.location{
                //Text("Your coordinates are: \(location.longitude), \(location.latitude)")
                if let weather = weather{
                    WeatherView(weather: weather)
                }else{
                    LoadingView()
                        .task {
                            do{
                                weather =  try await weatherManager.getCurrentWeather(latitude: 60.383, longitude: 14.333)
                            }catch{
                                print("Error printing weather:  \(error)")
                            }
                        }
                }
            }else{
                if locationManager.isLoading{
                    LoadingView()
                }else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider{ 
    static var previews: some View{ 
        ContentView()
    }
}
