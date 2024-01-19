//
//  Home.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct Home: View {
    /// The TemperaturaViewModel has been moved to the environment object.
    /// To make all the data available to child components of this view.
    @EnvironmentObject var azaWeatherVM: WeatherViewModel
    
    /// The location manager is the class that fetches the location of the user
    /// This requires 'Privacy' location proerties in the info.plist file.
    @ObservedObject var lm = LocationManager()
    
    /// Show the search city text field or not.
    @State var searchCity: Bool = false
    
    @State var iconScaleInitSize: CGFloat = 0.0
    
    @State var showAlert: Bool = false
    
    /// The city associated with the area.
    var placemark: String { return("\(lm.placemark?.locality ?? "")") }
    
    /// Additional city-level information for the area.
    var subLocality: String { return("\(lm.placemark?.subLocality ?? "")") }
    
    /// Administrative area could be state or province.
    var administrativeArea: String { return("\(lm.placemark?.administrativeArea ?? "")") }
    
    /// Latitude coordinate of the area.
    var latitude: Double  { return lm.location?.latitude ?? 0 }
    
    /// Longitude coordinate of the area.
    var longitude: Double { return lm.location?.longitude ?? 0 }
    
    /// The zip code of the area.
    var zip: String { return lm.placemark?.postalCode ?? "2091" }
    
    /// The country code of the area.
    var country_code: String { return lm.placemark?.isoCountryCode ?? "ZA" }
    
    /// The name of the country.
    var country_name: String { return lm.placemark?.country ?? "South Africa" }
    
    @State var searchField = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: self.azaWeatherVM.loadBackgroundImage ? [Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)), Color(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1))] : [Color(#colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.262745098, alpha: 1)), Color(#colorLiteral(red: 0.3647058824, green: 0.5058823529, blue: 0.6549019608, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                /// Top Info (weather condition, city, date and weather icon).
                VStack {
                    HStack(spacing: 32) {
                        /// City search text field.
                        HStack {
                            TextField("Enter city name", text: self.$searchField) {
                                self.azaWeatherVM.search(searchText: self.searchField)
//                                self.temperaturaVM.cityName = ""
                            }
                            .padding()
                            
                            Button(action: { self.searchField = "" }) {
                                Text("Clear")
                            }
                            .padding(.trailing)
                        }
                        .background(Color.white.opacity(0.30))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Button(action: {
                            self.azaWeatherVM.getWeatherByZipCode(by: self.zip, country_code: self.country_code)
                            self.showAlert = true
                        }) {
                            Image(systemName: "location.fill")
                        }
                        .font(.system(size: 21))
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black.opacity(0.20), radius: 5, x: 0, y: 6)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Your Location"), message: Text("You are currently based at \(self.placemark), \(self.administrativeArea) \(self.country_name)"), dismissButton: .default(Text("OK!")))
                        }
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    
                    /// Weather icon, description, place and date.
                    HStack {
                        Image("\(self.azaWeatherVM.weatherIcon)")
                            .resizable()
                            .frame(width: 92, height: 92)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                        VStack(alignment: .trailing, spacing: 5.0) {
                            Text(self.azaWeatherVM.description.capitalized)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                            Text(self.azaWeatherVM.city_country)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                            Text(self.azaWeatherVM.date)
                                .font(.footnote)
                                .foregroundColor(.white)
                                .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    /// Temperature reading.
                    Text("\(self.azaWeatherVM.temperature)°")
                        .font(.system(size: 72))
                        .bold()
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                    
                    /// Sunrise and sunset.
                    HStack(spacing: 40) {
                        HStack {
                            Image(systemName: "sunrise")
                            Text("\(self.azaWeatherVM.sunrise.replacingOccurrences(of: "AM", with: "")) am")
                        }

                        HStack {
                            Image(systemName: "sunset")
                            Text("\(self.azaWeatherVM.sunset.replacingOccurrences(of: "PM", with: "")) pm")
                        }
                    }
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
                    
                    /// Grid view of other weather details.
                    VStack(spacing: 47) {
                        HStack(spacing: 5) {
                            DetailCell(icon: "thermometer.sun", title: "Humidity", data: self.azaWeatherVM.temperature, unit: "%")
                            Spacer()
                            DetailCell(icon: "tornado", title: "Wind Speed", data: self.azaWeatherVM.wind_speed, unit: "Km/hr")
                        }
                        
                        HStack(spacing: 5) {
                            DetailCell(icon: "arrow.down.circle", title: "Min Temp", data: self.azaWeatherVM.temp_min, unit: "°C")
                            Divider().frame(height: 50).background(Color.white)
                            DetailCell(icon: "arrow.up.circle", title: "Max Temp", data: self.azaWeatherVM.temp_max, unit: "°C")
                        }
                        
                        HStack(spacing: 5) {
                            DetailCell(icon: "heart", title: "Feels Like", data: "32.4", unit: "°C")
                            Divider().frame(height: 50).background(Color.white)
                            DetailCell(icon: "rectangle.compress.vertical", title: "Pressure", data: "1002", unit: "hPa")
                        }
                    }
                    .padding(.vertical, 30)
                    .background(Color.secondary.opacity(0.30))
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }
                
            }
            .padding(.top)
            .padding(.horizontal)
            .onAppear() {
                self.azaWeatherVM.getWeatherByZipCode(by: self.zip, country_code: self.country_code)
            }
            .edgesIgnoringSafeArea(.horizontal)
            
        }.background(Color.red)
    }
}

/// Refactored weather detail grid cell.
struct DetailCell: View {
    var icon: String = "thermometer.sun"
    var title: String = "Humidity"
    var data: String = "30.0"
    var unit: String = "%"
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 33, weight: .thin))
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 5.0) {
                Text(title)
                    .foregroundColor(Color(#colorLiteral(red: 0.5607843137, green: 0.7411764706, blue: 0.9803921569, alpha: 1)))
                HStack {
                    Text("\(data)")
                        .font(.system(size: 21))
                        .bold()
                        .foregroundColor(.white)
                    Text(unit)
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 3)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(WeatherViewModel())
    }
}
