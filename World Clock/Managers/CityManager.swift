// CityManager.swift
// Manages the list of cities and user selections

import Foundation
import Combine

class CityManager: ObservableObject {
    static let shared = CityManager()
    
    @Published var cities: [City] = []
    
    private let userDefaultsKey = "selectedCities"
    
    private init() {
        // Load cities and selections
        loadCities()
        loadSelectedCities()
    }
    
    func loadCities() {
        cities = [
            // Japan
            City(name: "Tokyo", shortName: "TKY", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Osaka", shortName: "OSA", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Sapporo", shortName: "SAP", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Fukuoka", shortName: "FUK", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Nagoya", shortName: "NGO", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Yokohama", shortName: "YOK", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Okinawa", shortName: "OKA", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),

            // United States
            City(name: "New York", shortName: "NY", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Los Angeles", shortName: "LA", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Chicago", shortName: "CHI", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Houston", shortName: "HOU", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Phoenix", shortName: "PHX", timezone: "America/Phoenix", flag: "🇺🇸", region: "United States"),
            City(name: "Philadelphia", shortName: "PHI", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "San Antonio", shortName: "SA", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "San Diego", shortName: "SD", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Dallas", shortName: "DAL", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "San Jose", shortName: "SJ", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Austin", shortName: "AUS", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Jacksonville", shortName: "JAX", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Fort Worth", shortName: "FW", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Columbus", shortName: "COL", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Charlotte", shortName: "CHA", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "San Francisco", shortName: "SF", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Indianapolis", shortName: "IND", timezone: "America/Indiana/Indianapolis", flag: "🇺🇸", region: "United States"),
            City(name: "Seattle", shortName: "SEA", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Denver", shortName: "DEN", timezone: "America/Denver", flag: "🇺🇸", region: "United States"),
            City(name: "Boston", shortName: "BOS", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Portland", shortName: "POR", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Las Vegas", shortName: "LV", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Detroit", shortName: "DET", timezone: "America/Detroit", flag: "🇺🇸", region: "United States"),
            City(name: "Miami", shortName: "MIA", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Boise", shortName: "BOI", timezone: "America/Boise", flag: "🇺🇸", region: "United States"),
            City(name: "Washington D.C.", shortName: "DC", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Atlanta", shortName: "ATL", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Nashville", shortName: "NSH", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "New Orleans", shortName: "NOL", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Honolulu", shortName: "HNL", timezone: "Pacific/Honolulu", flag: "🇺🇸", region: "United States"),
            City(name: "Anchorage", shortName: "ANC", timezone: "America/Anchorage", flag: "🇺🇸", region: "United States"),

            // Canada
            City(name: "Toronto", shortName: "TOR", timezone: "America/Toronto", flag: "🇨🇦", region: "Canada"),
            City(name: "Vancouver", shortName: "VAN", timezone: "America/Vancouver", flag: "🇨🇦", region: "Canada"),
            City(name: "Montreal", shortName: "MTL", timezone: "America/Montreal", flag: "🇨🇦", region: "Canada"),
            City(name: "Calgary", shortName: "CAL", timezone: "America/Edmonton", flag: "🇨🇦", region: "Canada"),
            City(name: "Ottawa", shortName: "OTT", timezone: "America/Toronto", flag: "🇨🇦", region: "Canada"),
            City(name: "Edmonton", shortName: "EDM", timezone: "America/Edmonton", flag: "🇨🇦", region: "Canada"),
            City(name: "Winnipeg", shortName: "WPG", timezone: "America/Winnipeg", flag: "🇨🇦", region: "Canada"),
            City(name: "Halifax", shortName: "HAL", timezone: "America/Halifax", flag: "🇨🇦", region: "Canada"),
            City(name: "Quebec City", shortName: "QUE", timezone: "America/Toronto", flag: "🇨🇦", region: "Canada"),
            City(name: "Victoria", shortName: "VIC", timezone: "America/Vancouver", flag: "🇨🇦", region: "Canada"),

            // Philippines
            City(name: "Manila", shortName: "MAN", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Cebu", shortName: "CEB", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Davao", shortName: "DAV", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Quezon City", shortName: "QC", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            
            // Mexico
            City(name: "Mexico City", shortName: "MEX", timezone: "America/Mexico_City", flag: "🇲🇽", region: "Mexico"),
            City(name: "Guadalajara", shortName: "GDL", timezone: "America/Mexico_City", flag: "🇲🇽", region: "Mexico"),
            City(name: "Monterrey", shortName: "MTY", timezone: "America/Monterrey", flag: "🇲🇽", region: "Mexico"),
            City(name: "Cancún", shortName: "CUN", timezone: "America/Cancun", flag: "🇲🇽", region: "Mexico"),
            
            // Europe
            City(name: "London", shortName: "LON", timezone: "Europe/London", flag: "🇬🇧", region: "Europe"),
            City(name: "Paris", shortName: "PAR", timezone: "Europe/Paris", flag: "🇫🇷", region: "Europe"),
            City(name: "Berlin", shortName: "BER", timezone: "Europe/Berlin", flag: "🇩🇪", region: "Europe"),
            City(name: "Rome", shortName: "ROM", timezone: "Europe/Rome", flag: "🇮🇹", region: "Europe"),
            City(name: "Madrid", shortName: "MAD", timezone: "Europe/Madrid", flag: "🇪🇸", region: "Europe"),
            City(name: "Barcelona", shortName: "BCN", timezone: "Europe/Madrid", flag: "🇪🇸", region: "Europe"),
            City(name: "Amsterdam", shortName: "AMS", timezone: "Europe/Amsterdam", flag: "🇳🇱", region: "Europe"),
            City(name: "Vienna", shortName: "VIE", timezone: "Europe/Vienna", flag: "🇦🇹", region: "Europe"),
            City(name: "Prague", shortName: "PRG", timezone: "Europe/Prague", flag: "🇨🇿", region: "Europe"),
            City(name: "Lisbon", shortName: "LIS", timezone: "Europe/Lisbon", flag: "🇵🇹", region: "Europe"),
            City(name: "Athens", shortName: "ATH", timezone: "Europe/Athens", flag: "🇬🇷", region: "Europe"),
            City(name: "Venice", shortName: "VCE", timezone: "Europe/Rome", flag: "🇮🇹", region: "Europe"),
            City(name: "Florence", shortName: "FLR", timezone: "Europe/Rome", flag: "🇮🇹", region: "Europe"),
            City(name: "Dublin", shortName: "DUB", timezone: "Europe/Dublin", flag: "🇮🇪", region: "Europe"),
            City(name: "Copenhagen", shortName: "CPH", timezone: "Europe/Copenhagen", flag: "🇩🇰", region: "Europe"),
            City(name: "Stockholm", shortName: "STO", timezone: "Europe/Stockholm", flag: "🇸🇪", region: "Europe"),
            City(name: "Zurich", shortName: "ZRH", timezone: "Europe/Zurich", flag: "🇨🇭", region: "Europe"),
            City(name: "Brussels", shortName: "BRU", timezone: "Europe/Brussels", flag: "🇧🇪", region: "Europe"),
            City(name: "Edinburgh", shortName: "EDI", timezone: "Europe/London", flag: "🏴󠁧󠁢󠁳󠁣󠁴󠁿", region: "Europe"),
            City(name: "Istanbul", shortName: "IST", timezone: "Europe/Istanbul", flag: "🇹🇷", region: "Europe"),
            City(name: "Moscow", shortName: "MOW", timezone: "Europe/Moscow", flag: "🇷🇺", region: "Europe"),
            City(name: "Warsaw", shortName: "WAW", timezone: "Europe/Warsaw", flag: "🇵🇱", region: "Europe"),
            City(name: "Budapest", shortName: "BUD", timezone: "Europe/Budapest", flag: "🇭🇺", region: "Europe"),
            City(name: "Bucharest", shortName: "BUC", timezone: "Europe/Bucharest", flag: "🇷🇴", region: "Europe"),
            City(name: "Sofia", shortName: "SOF", timezone: "Europe/Sofia", flag: "🇧🇬", region: "Europe"),
            City(name: "Belgrade", shortName: "BEG", timezone: "Europe/Belgrade", flag: "🇷🇸", region: "Europe"),
            City(name: "Kyiv", shortName: "KYV", timezone: "Europe/Kyiv", flag: "🇺🇦", region: "Europe"),
            City(name: "Helsinki", shortName: "HEL", timezone: "Europe/Helsinki", flag: "🇫🇮", region: "Europe"),
            City(name: "Oslo", shortName: "OSL", timezone: "Europe/Oslo", flag: "🇳🇴", region: "Europe"),
            City(name: "Reykjavik", shortName: "REY", timezone: "Atlantic/Reykjavik", flag: "🇮🇸", region: "Europe"),
            City(name: "Luxembourg", shortName: "LUX", timezone: "Europe/Luxembourg", flag: "🇱🇺", region: "Europe"),
            City(name: "Bratislava", shortName: "BTS", timezone: "Europe/Bratislava", flag: "🇸🇰", region: "Europe"),
            City(name: "Zagreb", shortName: "ZAG", timezone: "Europe/Zagreb", flag: "🇭🇷", region: "Europe"),
            City(name: "Riga", shortName: "RIX", timezone: "Europe/Riga", flag: "🇱🇻", region: "Europe"),
            City(name: "Vilnius", shortName: "VNO", timezone: "Europe/Vilnius", flag: "🇱🇹", region: "Europe"),
            City(name: "Tallinn", shortName: "TLL", timezone: "Europe/Tallinn", flag: "🇪🇪", region: "Europe"),
            City(name: "Valletta", shortName: "MLA", timezone: "Europe/Malta", flag: "🇲🇹", region: "Europe"),
            City(name: "Munich", shortName: "MUC", timezone: "Europe/Berlin", flag: "🇩🇪", region: "Europe"),
            City(name: "Frankfurt", shortName: "FRA", timezone: "Europe/Berlin", flag: "🇩🇪", region: "Europe"),
            City(name: "Milan", shortName: "MIL", timezone: "Europe/Rome", flag: "🇮🇹", region: "Europe"),
            City(name: "Nice", shortName: "NCE", timezone: "Europe/Paris", flag: "🇫🇷", region: "Europe"),

            // Asia
            City(name: "Dubai", shortName: "DXB", timezone: "Asia/Dubai", flag: "🇦🇪", region: "Asia"),
            City(name: "Singapore", shortName: "SIN", timezone: "Asia/Singapore", flag: "🇸🇬", region: "Asia"),
            City(name: "Hong Kong", shortName: "HKG", timezone: "Asia/Hong_Kong", flag: "🇭🇰", region: "Asia"),
            City(name: "Bangkok", shortName: "BKK", timezone: "Asia/Bangkok", flag: "🇹🇭", region: "Asia"),
            City(name: "Seoul", shortName: "SEL", timezone: "Asia/Seoul", flag: "🇰🇷", region: "Asia"),
            City(name: "Shanghai", shortName: "SHA", timezone: "Asia/Shanghai", flag: "🇨🇳", region: "Asia"),
            City(name: "Beijing", shortName: "BJS", timezone: "Asia/Shanghai", flag: "🇨🇳", region: "Asia"),
            City(name: "Mumbai", shortName: "BOM", timezone: "Asia/Kolkata", flag: "🇮🇳", region: "Asia"),
            City(name: "Delhi", shortName: "DEL", timezone: "Asia/Kolkata", flag: "🇮🇳", region: "Asia"),
            City(name: "Taipei", shortName: "TPE", timezone: "Asia/Taipei", flag: "🇹🇼", region: "Asia"),
            City(name: "Kuala Lumpur", shortName: "KUL", timezone: "Asia/Kuala_Lumpur", flag: "🇲🇾", region: "Asia"),
            City(name: "Jakarta", shortName: "JKT", timezone: "Asia/Jakarta", flag: "🇮🇩", region: "Asia"),
            City(name: "Bali", shortName: "DPS", timezone: "Asia/Makassar", flag: "🇮🇩", region: "Asia"),
            City(name: "Hanoi", shortName: "HAN", timezone: "Asia/Bangkok", flag: "🇻🇳", region: "Asia"),
            City(name: "Ho Chi Minh City", shortName: "SGN", timezone: "Asia/Bangkok", flag: "🇻🇳", region: "Asia"),
            City(name: "Phuket", shortName: "HKT", timezone: "Asia/Bangkok", flag: "🇹🇭", region: "Asia"),
            City(name: "Kyoto", shortName: "KYO", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Asia"),
            City(name: "Chengdu", shortName: "CTU", timezone: "Asia/Shanghai", flag: "🇨🇳", region: "Asia"),
            City(name: "Guangzhou", shortName: "CAN", timezone: "Asia/Shanghai", flag: "🇨🇳", region: "Asia"),
            City(name: "Shenzhen", shortName: "SZX", timezone: "Asia/Shanghai", flag: "🇨🇳", region: "Asia"),
            City(name: "Islamabad", shortName: "ISB", timezone: "Asia/Karachi", flag: "🇵🇰", region: "Asia"),
            City(name: "Karachi", shortName: "KHI", timezone: "Asia/Karachi", flag: "🇵🇰", region: "Asia"),
            City(name: "Lahore", shortName: "LHE", timezone: "Asia/Karachi", flag: "🇵🇰", region: "Asia"),
            City(name: "Dhaka", shortName: "DAC", timezone: "Asia/Dhaka", flag: "🇧🇩", region: "Asia"),
            City(name: "Colombo", shortName: "CMB", timezone: "Asia/Colombo", flag: "🇱🇰", region: "Asia"),
            City(name: "Kathmandu", shortName: "KTM", timezone: "Asia/Kathmandu", flag: "🇳🇵", region: "Asia"),
            City(name: "Ulaanbaatar", shortName: "ULN", timezone: "Asia/Ulaanbaatar", flag: "🇲🇳", region: "Asia"),
            City(name: "Tashkent", shortName: "TAS", timezone: "Asia/Tashkent", flag: "🇺🇿", region: "Asia"),
            City(name: "Almaty", shortName: "ALA", timezone: "Asia/Almaty", flag: "🇰🇿", region: "Asia"),
            City(name: "Baku", shortName: "BAK", timezone: "Asia/Baku", flag: "🇦🇿", region: "Asia"),
            City(name: "Tbilisi", shortName: "TBS", timezone: "Asia/Tbilisi", flag: "🇬🇪", region: "Asia"),
            City(name: "Yerevan", shortName: "EVN", timezone: "Asia/Yerevan", flag: "🇦🇲", region: "Asia"),
            City(name: "Yangon", shortName: "RGN", timezone: "Asia/Yangon", flag: "🇲🇲", region: "Asia"),
            City(name: "Phnom Penh", shortName: "PNH", timezone: "Asia/Phnom_Penh", flag: "🇰🇭", region: "Asia"),
            City(name: "Vientiane", shortName: "VTE", timezone: "Asia/Vientiane", flag: "🇱🇦", region: "Asia"),
            City(name: "Bandar Seri Begawan", shortName: "BWN", timezone: "Asia/Brunei", flag: "🇧🇳", region: "Asia"),

            // Oceania
            City(name: "Sydney", shortName: "SYD", timezone: "Australia/Sydney", flag: "🇦🇺", region: "Oceania"),
            City(name: "Melbourne", shortName: "MEL", timezone: "Australia/Melbourne", flag: "🇦🇺", region: "Oceania"),
            City(name: "Brisbane", shortName: "BNE", timezone: "Australia/Brisbane", flag: "🇦🇺", region: "Oceania"),
            City(name: "Perth", shortName: "PER", timezone: "Australia/Perth", flag: "🇦🇺", region: "Oceania"),
            City(name: "Auckland", shortName: "AKL", timezone: "Pacific/Auckland", flag: "🇳🇿", region: "Oceania"),
            City(name: "Wellington", shortName: "WLG", timezone: "Pacific/Auckland", flag: "🇳🇿", region: "Oceania"),
            City(name: "Gold Coast", shortName: "OOL", timezone: "Australia/Brisbane", flag: "🇦🇺", region: "Oceania"),
            City(name: "Queenstown", shortName: "ZQN", timezone: "Pacific/Auckland", flag: "🇳🇿", region: "Oceania"),
            City(name: "Suva", shortName: "SUV", timezone: "Pacific/Fiji", flag: "🇫🇯", region: "Oceania"),
            City(name: "Port Moresby", shortName: "POM", timezone: "Pacific/Port_Moresby", flag: "🇵🇬", region: "Oceania"),
            City(name: "Nouméa", shortName: "NOU", timezone: "Pacific/Noumea", flag: "🇳🇨", region: "Oceania"),

            // Middle East & Africa
            City(name: "Tel Aviv", shortName: "TLV", timezone: "Asia/Jerusalem", flag: "🇮🇱", region: "Middle East"),
            City(name: "Jerusalem", shortName: "JRS", timezone: "Asia/Jerusalem", flag: "🇮🇱", region: "Middle East"),
            City(name: "Abu Dhabi", shortName: "AUH", timezone: "Asia/Dubai", flag: "🇦🇪", region: "Middle East"),
            City(name: "Doha", shortName: "DOH", timezone: "Asia/Qatar", flag: "🇶🇦", region: "Middle East"),
            City(name: "Riyadh", shortName: "RUH", timezone: "Asia/Riyadh", flag: "🇸🇦", region: "Middle East"),
            City(name: "Tehran", shortName: "THR", timezone: "Asia/Tehran", flag: "🇮🇷", region: "Middle East"),
            City(name: "Baghdad", shortName: "BGW", timezone: "Asia/Baghdad", flag: "🇮🇶", region: "Middle East"),
            City(name: "Amman", shortName: "AMM", timezone: "Asia/Amman", flag: "🇯🇴", region: "Middle East"),
            City(name: "Beirut", shortName: "BEY", timezone: "Asia/Beirut", flag: "🇱🇧", region: "Middle East"),
            City(name: "Kuwait City", shortName: "KWI", timezone: "Asia/Kuwait", flag: "🇰🇼", region: "Middle East"),
            City(name: "Manama", shortName: "BAH", timezone: "Asia/Bahrain", flag: "🇧🇭", region: "Middle East"),
            City(name: "Muscat", shortName: "MCT", timezone: "Asia/Muscat", flag: "🇴🇲", region: "Middle East"),
            City(name: "Cairo", shortName: "CAI", timezone: "Africa/Cairo", flag: "🇪🇬", region: "Africa"),
            City(name: "Marrakech", shortName: "RAK", timezone: "Africa/Casablanca", flag: "🇲🇦", region: "Africa"),
            City(name: "Casablanca", shortName: "CAS", timezone: "Africa/Casablanca", flag: "🇲🇦", region: "Africa"),
            City(name: "Cape Town", shortName: "CPT", timezone: "Africa/Johannesburg", flag: "🇿🇦", region: "Africa"),
            City(name: "Johannesburg", shortName: "JNB", timezone: "Africa/Johannesburg", flag: "🇿🇦", region: "Africa"),
            City(name: "Nairobi", shortName: "NBO", timezone: "Africa/Nairobi", flag: "🇰🇪", region: "Africa"),
            City(name: "Lagos", shortName: "LOS", timezone: "Africa/Lagos", flag: "🇳🇬", region: "Africa"),
            City(name: "Accra", shortName: "ACC", timezone: "Africa/Accra", flag: "🇬🇭", region: "Africa"),
            City(name: "Addis Ababa", shortName: "ADD", timezone: "Africa/Addis_Ababa", flag: "🇪🇹", region: "Africa"),
            City(name: "Tunis", shortName: "TUN", timezone: "Africa/Tunis", flag: "🇹🇳", region: "Africa"),
            City(name: "Algiers", shortName: "ALG", timezone: "Africa/Algiers", flag: "🇩🇿", region: "Africa"),
            City(name: "Dakar", shortName: "DKR", timezone: "Africa/Dakar", flag: "🇸🇳", region: "Africa"),
            City(name: "Kinshasa", shortName: "FIH", timezone: "Africa/Kinshasa", flag: "🇨🇩", region: "Africa"),
            City(name: "Kampala", shortName: "KLA", timezone: "Africa/Kampala", flag: "🇺🇬", region: "Africa"),
            City(name: "Dar es Salaam", shortName: "DAR", timezone: "Africa/Dar_es_Salaam", flag: "🇹🇿", region: "Africa"),
            City(name: "Harare", shortName: "HRE", timezone: "Africa/Harare", flag: "🇿🇼", region: "Africa"),
            City(name: "Lusaka", shortName: "LUN", timezone: "Africa/Lusaka", flag: "🇿🇲", region: "Africa"),
            City(name: "Windhoek", shortName: "WDH", timezone: "Africa/Windhoek", flag: "🇳🇦", region: "Africa"),

            // South America
            City(name: "São Paulo", shortName: "SAO", timezone: "America/Sao_Paulo", flag: "🇧🇷", region: "South America"),
            City(name: "Rio de Janeiro", shortName: "RIO", timezone: "America/Sao_Paulo", flag: "🇧🇷", region: "South America"),
            City(name: "Buenos Aires", shortName: "BUE", timezone: "America/Argentina/Buenos_Aires", flag: "🇦🇷", region: "South America"),
            City(name: "Lima", shortName: "LIM", timezone: "America/Lima", flag: "🇵🇪", region: "South America"),
            City(name: "Bogotá", shortName: "BOG", timezone: "America/Bogota", flag: "🇨🇴", region: "South America"),
            City(name: "Santiago", shortName: "SCL", timezone: "America/Santiago", flag: "🇨🇱", region: "South America"),
            City(name: "Cusco", shortName: "CUZ", timezone: "America/Lima", flag: "🇵🇪", region: "South America"),
            City(name: "Caracas", shortName: "CCS", timezone: "America/Caracas", flag: "🇻🇪", region: "South America"),
            City(name: "Quito", shortName: "UIO", timezone: "America/Guayaquil", flag: "🇪🇨", region: "South America"),
            City(name: "La Paz", shortName: "LPB", timezone: "America/La_Paz", flag: "🇧🇴", region: "South America"),
            City(name: "Montevideo", shortName: "MVD", timezone: "America/Montevideo", flag: "🇺🇾", region: "South America"),
            City(name: "Asunción", shortName: "ASU", timezone: "America/Asuncion", flag: "🇵🇾", region: "South America"),
            City(name: "Georgetown", shortName: "GEO", timezone: "America/Guyana", flag: "🇬🇾", region: "South America"),

            // Caribbean & Central America
            City(name: "Havana", shortName: "HAV", timezone: "America/Havana", flag: "🇨🇺", region: "Caribbean"),
            City(name: "San Juan", shortName: "SJU", timezone: "America/Puerto_Rico", flag: "🇵🇷", region: "Caribbean"),
            City(name: "Nassau", shortName: "NAS", timezone: "America/Nassau", flag: "🇧🇸", region: "Caribbean"),
            City(name: "Panama City", shortName: "PTY", timezone: "America/Panama", flag: "🇵🇦", region: "Central America"),
            City(name: "San José", shortName: "SJO", timezone: "America/Costa_Rica", flag: "🇨🇷", region: "Central America"),
            City(name: "Kingston", shortName: "KIN", timezone: "America/Jamaica", flag: "🇯🇲", region: "Caribbean"),
            City(name: "Santo Domingo", shortName: "SDQ", timezone: "America/Santo_Domingo", flag: "🇩🇴", region: "Caribbean"),
            City(name: "Guatemala City", shortName: "GUA", timezone: "America/Guatemala", flag: "🇬🇹", region: "Central America"),
            City(name: "Tegucigalpa", shortName: "TGU", timezone: "America/Tegucigalpa", flag: "🇭🇳", region: "Central America"),
            City(name: "Managua", shortName: "MGA", timezone: "America/Managua", flag: "🇳🇮", region: "Central America"),
            City(name: "San Salvador", shortName: "SAL", timezone: "America/El_Salvador", flag: "🇸🇻", region: "Central America"),
            City(name: "Belize City", shortName: "BZE", timezone: "America/Belize", flag: "🇧🇿", region: "Central America"),
        ]
    }
    
    func toggleCity(_ city: City) {
        if let index = cities.firstIndex(where: { $0.id == city.id }) {
            let selectedCount = cities.filter { $0.isSelected }.count
            
            // Check if trying to select more than 5 cities
            if !cities[index].isSelected && selectedCount >= 5 {
                return
            }
            
            cities[index].isSelected.toggle()
            saveSelectedCities()
            
            // Notify AppDelegate to update menu bar
            NotificationCenter.default.post(name: NSNotification.Name("UpdateMenuBar"), object: nil)
        }
    }
    
    func getSelectedCities() -> [City] {
        return cities.filter { $0.isSelected }
    }
    
    func saveSelectedCities() {
        let selectedNames = cities.filter { $0.isSelected }.map { $0.name }
        UserDefaults.standard.set(selectedNames, forKey: userDefaultsKey)
    }
    
    func loadSelectedCities() {
        guard let selectedNames = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] else { return }
        
        for i in 0..<cities.count {
            if selectedNames.contains(cities[i].name) {
                cities[i].isSelected = true
            }
        }
    }
}
