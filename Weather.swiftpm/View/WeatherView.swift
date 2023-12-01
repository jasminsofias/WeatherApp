import SwiftUI



struct WeatherView: View {
    var weather: [ResponseBody]
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack{
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(weather[0].timeSeries[0].validTime)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
        
}

struct WeatherView_Previews: PreviewProvider{ 
    static var previews: some View{ 
        WeatherView(weather: previewWeather)
    }
}
