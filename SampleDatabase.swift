//
//  SampleDatabase.swift
//  nextAPI
//
//  Created by rob on 8/8/22.
//

import Foundation

public protocol SampleDatabase {
    
    init(_ clientID : String)
    
    func getClientID() -> Array<u8>
    
    func getAppleID() -> Array<u8>
    
    func storeUser(_ sampleUser : SampleUser)
    
    func storeAuth(_ authToken : Array<u8>, _ appleID : Array<u8>, _ userID : u32)
    
    func storeHistoricalTime(_ tableID : u8, _ userID : u32, _ timestamp : u32)
    
    func storeUserSettings(_ settings : UserSettings)
    
    func storeDeviceInfo(_ device : SampleDevice, _ encKey : Array<u8>,
                         _ regKey : String, _ imageID : u32)
    
    func storeDeviceUsers(_ device : SampleDevice)
    
    func storeImage(_ imageID : u32, _ image : Data)
    
    func storeClientPermissions(_ clientPermissions : ClientPermissions)
    
    func storeTrip(_ trip : TripInformation)
    
    func storeTripPoint(_ point : LocationCoordinate)
    
    func storeDeviceSettings(_ settings : DeviceSettingControls)
    
    func storeAggregate(_ aggregate : DrivingAggregate)
    
    func storeTripToAggregate(_ tripToAggregate : ToAggregate)
    
    func storeAlertToAggregate(_ alertToAggregate : ToAggregate)
    
    func storeAlert(_ alert : AlertInfo)
    
    /// Load account info into the SampleUser
    func loadUser(_ sampleUser : SampleUser)
    
    /// Load account info into the SampleUserAccount
    func loadUserAccount(_ sampleUserAccount : SampleUserAccount,
                         _ sampleDeviceManager : SampleDeviceManager,
                         _ userAccountsManager : UserAccountsManager)
    
    func loadHistoricalTime(_ historical : Historical)
    
    func loadDeviceInfo(_ sampleDevice : SampleDevice)
    
    func loadImage(_ imageID : u32, _ identifier : BasicIdentifier)
    
    func loadClientPermissions(_ clientPermissions : ClientPermissions)
    
    func loadTrip(_ trip : TripInformation)
    
    func loadPointsByTrip(_ trip : TripInformation)
    
    func loadLastPointForTrip(_ last_index : Int, _ trip : TripInformation)
    
    func loadAggregate(_ aggregate : DrivingAggregate)
    
    func loadTripIDsForAggregate(_ aggregate : DrivingAggregate)
    
    func loadTripsForAggregate(_ aggregate : DrivingAggregate)
    
    func loadAlertsForAggregate(_ aggregate : DrivingAggregate)
    
    func loadAlertsForTrip(_ trip : TripInformation)
    
    func loadAlert(_ alert : AlertInfo)
    
    func deleteAuth()
    
}
