//
//  SampleDatabaseImpl.swift
//  nextAPI
//
//  Created by rob on 8/8/22.
//

import Foundation
import CoreData

public class SampleDatabaseImpl : SampleDatabase {
    
    private let uuid_separator : Character = "-"
    
    // 09/16/2022: list of column names
    // 10/03/2022: for AuthToken
    private let auth_token : String = "auth_token"
    private let apple_id : String = "apple_id"
    // 10/03/2022: for UserInfo
    private let email : String = "email"
    private let first_name : String = "first_name"
    private let id : String = "id"
    private let image_id : String = "image_id"
    private let last_device : String = "last_device"
    private let last_name : String = "last_name"
    private let last_trip : String = "last_trip"
    private let phone : String = "phone"
    private let terms_id : String = "terms_id"
    private let time : String = "time"
    private let username : String = "username"
    // 10/03/2022: for UserSettings
    private let user_id : String = "user_id"
    private let accident_notif : String = "accident_notif"
    private let all_notif : String = "all_notif"
    private let auto_key : String = "auto_key"
    private let behavior_notif : String = "behavior_notif"
    private let diagnostic_notif : String = "diagnostic_notif"
    private let email_notif : String = "email_notif"
    private let emergency_contacts : String = "emergency_contacts"
    private let inapp_notif : String = "inapp_notif"
    private let safety_notif : String = "safety_notif"
    private let security_notif : String = "security_notif"
    private let text_notif : String = "text_notif"
    private let threshold_notif : String = "threshold_notif"
    private let traffic_notif : String = "traffic_notif"
    private let last_changed : String = "last_changed"
    private let overspeed : String = "overspeed"
    private let privacy : String = "privacy"
    private let unit_system : String = "unit_system"
    private let roadside : String = "roadside"
    private let snapshot : String = "snapshot"
    // 10/06/2022: for DeviceInfo
    private let enc_key : String = "enc_key"
    private let firmware_ver : String = "firmware_ver"
    private let hardware_ver : String = "hardware_ver"
    private let devname : String = "devname"
    private let reg_key : String = "reg_key"
    private let last_user : String = "last_user"
    private let obd_serial : String = "obd_serial"
    // 11/02/2022: for DeviceUser
    private let permission : String = "permission"
    // 10/07/2022: for SampleImage
    private let image : String = "image"
    // 11/09/2022: for TripInfo
    private let alert_count : String = "alert_count"
    private let points_total : String = "points_total"
    private let duration : String = "duration"
    private let idle_time : String = "idle_time"
    private let stop_time : String = "stop_time"
    private let start_time : String = "start_time"
    private let end_time : String = "end_time"
    private let co2_saved : String = "co2_saved"
    private let distance : String = "distance"
    private let economy : String = "economy"
    private let fuel_saved : String = "fuel_saved"
    private let fuel_used : String = "fuel_used"
    private let start_stop : String = "start_stop"
    private let valid_gps : String = "valid_gps"
    // 11/11/2022: for TripPoint
    private let trip_id : String = "trip_id"
    private let gps_time : String = "gps_time"
    private let latitude : String = "latitude"
    private let longitude : String = "longitude"
    private let index : String = "index"
    private let heading : String = "heading"
    // 11/23/2022: for DeviceSetting
    private let auto_stop_time : String = "auto_stop_time"
    private let auto_stop : String = "auto_stop"
    private let immobilize : String = "immobilize"
    private let key_driver_door : String = "key_driver_door"
    private let lock_unlock : String = "lock_unlock"
    private let proximity_mobilize : String = "proximity_mobilize"
    private let sched_immobilize : String = "sched_immobilize"
    private let stop_park : String = "stop_park"
    // 12/08/2022: for Aggregate
    private let agg_type : String = "agg_type"
    private let creator_id : String = "creator_id"
    private let trip_count : String = "trip_count"
    
    // 09/16/2022: list of query operators
    private let equals_int : String = " == %i"
    private let empty : String = ""
    
    
    private let mClientID : String
    
    //private var model : NSManagedObjectModel?
    private var container : NSPersistentContainer
    
    public required init(_ clientID: String) {
    
        mClientID = clientID
        
        let bundle : Bundle = Bundle(identifier : "com.sample.nextAPI")!
        let url = bundle.url(forResource : "SampleDataModel", withExtension : "momd")!
        let model : NSManagedObjectModel = NSManagedObjectModel(contentsOf : url)!
        
        container = NSPersistentContainer(name : "SampleDataModel", managedObjectModel : model)
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores(completionHandler : loadHandler)
            
    }
    
    public func getClientID() -> Array<u8> {
        return nextAPI.hexStringToArr(mClientID)
    }
    
    public func getAppleID() -> Array<u8> {
        
        let uuid : String = NSUUID().uuidString.lowercased()

        return nextAPI.hexStringToArr(nextAPI.trimAll(uuid, uuid_separator))
    }
    
    public func storeUser(_ sampleUser : SampleUser) {
        
        container.performBackgroundTask { context in
            
            log("store user account with username " +
                  sampleUser.getName() + " and id " +
                  String(sampleUser.getId()))
        
            // 09/16/2022: create and populate the user account
            // dictionary
            var dict : [String : Any] = [:]
            
            dict[self.email] = sampleUser.getEmail()
            dict[self.first_name] = sampleUser.getFirstName()
            dict[self.last_name] = sampleUser.getLastName()
            dict[self.phone] = sampleUser.getPhone()
            dict[self.username] = sampleUser.getName()
            dict[self.last_trip] = sampleUser.getLastTripID()
            dict[self.id] = nextAPI.toInt(sampleUser.getId())
            dict[self.image_id] = nextAPI.toInt(sampleUser.getAvatarID())
            dict[self.last_device] = nextAPI.toInt(sampleUser.getLastPairing()?.getId() ?? 0)
            dict[self.terms_id] = nextAPI.toInt(sampleUser.getTermsID())
        
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : UserInfo.entity(),
                objects : [dict])
            
            if(!self.push(context, insert)) {
                
                // 09/23/2022: insert failed, update instead
                
                dict.removeValue(forKey : self.id)
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(entity : UserInfo.entity())
        
                update.predicate = NSPredicate(format : self.id + self.equals_int, nextAPI.toInt(sampleUser.getId()))
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    
                    log("store user account failed")
                }
                
            }
            
        }
    }
    
    public func storeAuth(_ authToken : Array<u8>,
                          _ appleID : Array<u8>,
                          _ userID : u32) {
        
        container.performBackgroundTask { context in
            
            var tStr2 : String = ""
            var aStr2 : String = ""
            
            for datum in appleID {
                tStr2 += String(datum)
            }
            for datum in authToken {
                aStr2 += String(datum)
            }
            
            log("store auth " + String(nextAPI.toInt(userID)))
            log("store auth token " + tStr2)
            log("store apple id " + aStr2)
            
            var token_data : Data = Data()
            token_data.append(contentsOf: authToken)
            
            var apple_data : Data = Data()
            apple_data.append(contentsOf : appleID)
            
            var dict : [String : Any] = [:]
            dict[self.auth_token] = token_data
            dict[self.apple_id] = apple_data
            dict[self.user_id] = nextAPI.toInt(userID)
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : AuthToken.entity(),
                objects : [dict])
            
            if(!self.push(context, insert)) {
                log("store auth failed")
            }
            
            // 01/31/2023: for debugging only
//            let fetch : NSFetchRequest<AuthToken> = AuthToken.fetchRequest()
//
//            let fetchResults : [AuthToken] = self.pull(context, fetch)
//
//            for token in fetchResults {
//
//                var tStr : String = ""
//                var aStr : String = ""
//
//                for datum in token.auth_token ?? Data() {
//                    tStr += String(datum)
//                }
//                for datum in token.apple_id ?? Data() {
//                    aStr += String(datum)
//                }
//
//                log("stored user id is " + String(token.user_id))
//                log("stored auth token is " + tStr)
//                log("stored apple id is " + aStr)
//            }
            
        }
            
    }
    
    public func storeHistoricalTime(_ tableID : u8, _ userID : u32, _ timestamp : u32) {
        
        container.performBackgroundTask { context in
            log("store last updated time")

            
            // 09/20/2022: define time as the updated parameter and set
            // its value to the timestamp argument
            var dict : [String : Any] = [:]
            dict[self.time] = nextAPI.toInt(timestamp)
            dict[self.id] = nextAPI.toS16(tableID)
            dict[self.user_id] = nextAPI.toInt(userID)

            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : HistoricalTime.entity(),
                objects : [dict])
            
            // 09/20/2022: execute the store request
            if(!self.push(context, insert)) {
                
                // 09/23/2022: insert failed, update instead
                
                dict.removeValue(forKey : self.id)
                dict.removeValue(forKey : self.user_id)
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(entity : HistoricalTime.entity())
                
                update.predicate = NSCompoundPredicate(andPredicateWithSubpredicates : [
                    NSPredicate(format : self.id + self.equals_int,
                                nextAPI.toS16(tableID)),
                    NSPredicate(format : self.user_id + self.equals_int,
                                nextAPI.toInt(userID))
                
                ])
                
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    log("store update times failed")
                }
            }
        }
        
    }
    
    public func storeUserSettings(_ settings : UserSettings) {
        container.performBackgroundTask { context in
            log("store user settings")
            
            let user_id : u32 = SampleAPIImpl.getInstance()
                .getUserAccountsManager().getSampleUserAccount().getId() ?? 0
            
            var dict : [String : Any] = [:]
            dict[self.user_id] = nextAPI.toInt(user_id)
            dict[self.all_notif] = settings.getAllNotificationsEnabled()
            dict[self.traffic_notif] = settings.getTrafficNotificationsEnabled()
            dict[self.threshold_notif] = settings.getThresholdNotificationsEnabled()
            dict[self.auto_key] = settings.getAutoKeyEnabled()
            dict[self.safety_notif] = settings.getVehicleSafetyNotificationsEnabled()
            dict[self.emergency_contacts] = settings.getEmergencyContactsEnabled()
            dict[self.behavior_notif] = settings.getBehaviorNotificationsEnabled()
            dict[self.diagnostic_notif] = settings.getDiagnosticNotificationsEnabled()
            dict[self.security_notif] = settings.getSecurityNotificationsEnabled()
            dict[self.accident_notif] = settings.getAccidentNotificationsEnabled()
            dict[self.inapp_notif] = settings.getInAppNotificationsEnabled()
            dict[self.text_notif] = settings.getTextNotificationsEnabled()
            dict[self.email_notif] = settings.getEmailNotificationsEnabled()
            dict[self.unit_system] = nextAPI.toS16(settings.getUnitSystem().rawValue)
            dict[self.snapshot] = settings.getSnapshotEnabled()
            dict[self.privacy] = nextAPI.toS16(settings.getPrivacy().rawValue)
            dict[self.overspeed] = nextAPI.toS16(settings.getOverspeed())
            dict[self.last_changed] = nextAPI.toS64(settings.getLastChanged())
            dict[self.roadside] = settings.getRoadsideEnabled()
            
            
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : UserSetting.entity(),
                objects : [dict])
            
            if(!self.push(context, insert)) {
                
                // 10/03/2022: insert failed, so update instead
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(
                    entity : UserSetting.entity())
                
                dict.removeValue(forKey : self.user_id)
                
                update.predicate = NSPredicate(format : self.user_id + self.equals_int,
                                               nextAPI.toInt(user_id))
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    log("store user settings failed")
                }
            }
        }
    }
    
    public func storeDeviceInfo(_ device : SampleDevice,
                                _ encKey : Array<u8>,
                                _ regKey : String,
                                _ imageID : u32) {
        
        container.performBackgroundTask { context in
            
            log("store device info")
            
            var dict : [String : Any] = [:]
            
            var enc_data : Data = Data()
            enc_data.append(contentsOf : encKey)
            
            dict[self.obd_serial] = nextAPI.toInt(device.getId())
            dict[self.enc_key] = enc_data
            dict[self.devname] = device.getName()
            dict[self.firmware_ver] = device.getFirmware()
            dict[self.hardware_ver] = device.getHardware()
            dict[self.reg_key] = regKey
            dict[self.image_id] = nextAPI.toInt(imageID)
            dict[self.last_user] = nextAPI.toInt(device.getLastPairing()?.getId() ?? 0)
            dict[self.last_trip] = nextAPI.toInt(device.getLastTripID())
            
            
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : DeviceInfo.entity(),
                objects : [dict])
            
            if(!self.push(context, insert)) {
                
                // 10/12/2022: insert failed, update instead
                
                dict.removeValue(forKey : self.obd_serial)
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(entity : DeviceInfo.entity())
                update.predicate = NSPredicate(format : self.obd_serial + self.equals_int,
                                               nextAPI.toInt(device.getId()))
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    log("store device failed")
                }
            }
            
        }
    }
    
    public func storeDeviceUsers(_ device : SampleDevice) {
        
        container.performBackgroundTask { context in
            
            log("store devce users")
            
            var dict : [[String : Any]] = []
            
            for user in device.getUserControls().getUsers() {
                
                var user_dict : [String : Any] = [:]
                
                // 01/31/2023: bug fix: use the raw value of the
                // permission enum to store into CoreData
                user_dict[self.obd_serial] = nextAPI.toInt(device.getId())
                user_dict[self.user_id] = nextAPI.toInt(user.getId())
                user_dict[self.permission] = nextAPI.toS16(device.getUserControls().getPermission(user).rawValue)
                
                dict.append(user_dict)
            }
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(entity : DeviceUser.entity(), objects : dict)
            
            if(!self.push(context, insert)) {
                
                // 11/02/2022: insert failed, try to update
                // instead
                
                for user_dict in dict {
                    
                    let dev_id = nextAPI.toInt(user_dict[self.obd_serial])
                    let user_id = nextAPI.toInt(user_dict[self.user_id])
                    
                    let update : NSBatchUpdateRequest = NSBatchUpdateRequest(entity : DeviceUser.entity())
                    
                    update.propertiesToUpdate = [self.permission : nextAPI.toS16(user_dict[self.permission])]
                    
                    update.predicate = NSCompoundPredicate(
                        andPredicateWithSubpredicates : [
                            NSPredicate(format : self.user_id + self.equals_int,
                                       user_id),
                            NSPredicate(format : self.obd_serial + self.equals_int,
                                       dev_id)]
                    )
                    
                    if(!self.push(context, update)) {
                        log("store device users failed")
                    }
                    
                } // 11/02/2022: end for each device-user pairing
                
            } // 11/02/2022: end if the initial insert failed
            
        }
    }
    
    public func storeImage(_ imageID : u32, _ image : Data) {
        
        container.performBackgroundTask { context in
            
            log("store image")
            
            var dict : [String : Any] = [:]
            
            dict[self.id] = nextAPI.toInt(imageID)
            dict[self.image] = image
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(entity : SampleImage.entity(), objects : [dict])
            
            if(!self.push(context, insert)) {
                
                // 10/07/2022: insert failed, so update instead
                
                dict.removeValue(forKey : self.id)
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(entity : SampleImage.entity())
                
                update.predicate = NSPredicate(format : self.id + self.equals_int,
                                               nextAPI.toInt(imageID))
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    
                    log("store image failed")
                }
            }
        }
    }
    
    public func storeClientPermissions(_ clientPermissions : ClientPermissions) {
        
        container.performBackgroundTask { context in
            
            log("store client permissions")
            
            var dict : [String : Any] = [:]
            
            dict[self.permission] = Data(clientPermissions.getData())
            dict[self.id] = nextAPI.toS16(ServerPhoneMessage.CLIENT_PERM.rawValue)
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : ClientPermission.entity(),
                objects : [dict])
            
            if(!self.push(context, insert)) {
                // 11/04/2022: insert failed, try updating instead
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(
                    entity : ClientPermission.entity())
                update.predicate = NSPredicate(format : self.id + self.equals_int,
                                               nextAPI.toS16(dict[self.id]))
                
                dict.removeValue(forKey : self.id)
                
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    log("store client permissions failed")
                }
            }
        }
    }
    
    public func storeTrip(_ trip : TripInformation) {
        container.performBackgroundTask { context in
            
            log("store trip info")
            
            var dict : [String : Any] = [:]
            
            dict[self.id] = nextAPI.toInt(trip.getId())
            dict[self.alert_count] = nextAPI.toS16(trip.getNumAlerts())
            dict[self.points_total] = nextAPI.toS16(trip.getNumPoints())
            dict[self.duration] = nextAPI.toInt(trip.getTimeDriven())
            dict[self.idle_time] = nextAPI.toInt(trip.getIdleTimeSaved())
            dict[self.obd_serial] = nextAPI.toInt(trip.getCreator(.DEVICE)?.getId() ?? 0)
            dict[self.stop_time] = nextAPI.toInt(trip.getStoppedTime())
            dict[self.user_id] = nextAPI.toInt(trip.getCreator(.USER)?.getId() ?? 0)
            dict[self.end_time] = nextAPI.toS64(trip.getEndTime())
            dict[self.start_time] = nextAPI.toS64(trip.getStartTime())
            dict[self.co2_saved] = trip.getCo2Saved()
            dict[self.distance] = trip.getDistanceDriven()
            dict[self.economy] = trip.getFuelEconomy()
            dict[self.fuel_saved] = trip.getFuelSaved()
            dict[self.fuel_used] = trip.getFuelUsed()
            dict[self.start_stop] = trip.startStopActive()
            dict[self.valid_gps] = trip.hasValidGps()
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : TripInfo.entity(), objects : [dict])
            
            if(!self.push(context, insert)) {
                
                // 11/09/2022: insert failed, try updating instead
                
                dict.removeValue(forKey : self.id)
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(
                    entity : TripInfo.entity())
                update.predicate = NSPredicate(format : self.id + self.equals_int,
                                               nextAPI.toInt(trip.getId()))
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    log("store trip info failed")
                }
            }
            
            
        }
    }
    
    public func storeTripPoint(_ point: LocationCoordinate) {
        
        container.performBackgroundTask { context in
            
            log("store trip point")
            
            var dict : [String : Any] = [:]
            dict[self.heading] = nextAPI.toS16(point.getHeadingInDegrees())
            dict[self.index] = nextAPI.toInt(point.getIndex())
            dict[self.trip_id] = nextAPI.toInt(point.getTripID())
            dict[self.gps_time] = nextAPI.toS64(point.getTime())
            dict[self.latitude] = point.getLatitude()
            dict[self.longitude] = point.getLongitude()
            
            let insert : NSBatchInsertRequest =
            NSBatchInsertRequest(entity : TripPoint.entity(), objects : [dict])
            
            if(!self.push(context, insert)) {
                
                // 01/03/2022: insert failed, update instead
                
                dict.removeValue(forKey : self.trip_id)
                dict.removeValue(forKey : self.index)
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(entity : TripPoint.entity())

                update.predicate = NSCompoundPredicate(andPredicateWithSubpredicates : [
                    NSPredicate(format : self.trip_id + self.equals_int,
                                nextAPI.toInt(point.getTripID())),
                    NSPredicate(format : self.index + self.equals_int,
                                nextAPI.toInt(point.getIndex()))])
                
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    
                    log("store trip point failed")
                }
                
            }
            
        }
    }
    
    public func storeDeviceSettings(_ settings : DeviceSettingControls) {
        
        container.performBackgroundTask { context in
            log("store device settings")
            
            var dict : [String : Any] = [:]
            dict[self.auto_stop_time] = nextAPI.toS16(settings.getAutoStopDuration())
            dict[self.privacy] = nextAPI.toS16(settings.getPrivacySetting().rawValue)
            dict[self.obd_serial] = nextAPI.toInt(settings.getSerial())
            dict[self.auto_key] = settings.getAutoKeyAllowed()
            dict[self.auto_stop] = settings.getAutoStopEnabled()
            dict[self.immobilize] = settings.getImmobilizerEnabled()
            dict[self.key_driver_door] = settings.getKeyDriverDoorEnabled()
            dict[self.lock_unlock] = settings.getLockUnlockEnabled()
            dict[self.proximity_mobilize] = settings.getProximityMobilizeEnabled()
            dict[self.sched_immobilize] = settings.getScheduledImmobilizerEnabled()
            dict[self.start_stop] = settings.getStartStopEnabled()
            dict[self.stop_park] = settings.getStopParkEnabled()
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(
                entity : DeviceSetting.entity(),
                objects : [dict])
            
            if(!self.push(context, insert)) {
                // 11/28/2022: insert failed, update instead
                
                dict.removeValue(forKey : self.obd_serial)
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(
                    entity : DeviceSetting.entity())
                update.predicate = NSPredicate(format : self.obd_serial + self.equals_int,
                                               nextAPI.toInt(settings.getSerial()))
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    log("store device settings failed")
                }
            }
            
        }
    }
    
    public func storeAggregate(_ aggregate : DrivingAggregate) {
        
        container.performBackgroundTask { context in
            
            log("store aggregate")
            
            var dict : [String : Any] = [:]
            dict[self.id] = nextAPI.toInt(aggregate.getId())
            dict[self.alert_count] = nextAPI.toInt(aggregate.getNumAlerts())
            dict[self.creator_id] = nextAPI.toInt(aggregate.getSearchCriteria().getCreatorID())
            dict[self.distance] = aggregate.getDistanceDriven()
            dict[self.duration] = nextAPI.toInt(aggregate.getTimeDriven())
            dict[self.idle_time] = nextAPI.toInt(aggregate.getIdleTimeSaved())
            dict[self.stop_time] = nextAPI.toInt(aggregate.getStoppedTime())
            dict[self.trip_count] = nextAPI.toInt(aggregate.getNumTrips())
            dict[self.user_id] = nextAPI.toInt(aggregate.getSearchCriteria().getViewerID())
            dict[self.end_time] = nextAPI.toS64(aggregate.getEndTime())
            dict[self.start_time] = nextAPI.toS64(aggregate.getStartTime())
            dict[self.co2_saved] = aggregate.getCo2Saved()
            dict[self.economy] = aggregate.getFuelEconomy()
            dict[self.fuel_used] = aggregate.getFuelUsed()
            dict[self.fuel_saved] = aggregate.getFuelSaved()
            dict[self.agg_type] = nextAPI.toS16(aggregate.getSearchCriteria().getType().rawValue)
            
            let insert : NSBatchInsertRequest = NSBatchInsertRequest(entity : Aggregate.entity(), objects : [dict])
            
            if(!self.push(context, insert)) {
                
                // 12/13/2022: insert failed, try updating instead
                
                let update : NSBatchUpdateRequest = NSBatchUpdateRequest(entity : Aggregate.entity())
                
                dict.removeValue(forKey : self.id)
                
                update.predicate = NSPredicate(format : self.id + self.equals_int,
                                               nextAPI.toInt(aggregate.getId()))
                update.propertiesToUpdate = dict
                
                if(!self.push(context, update)) {
                    log("store aggregate failed")
                }
                
            }
            
        }
    }
    
    public func storeTripToAggregate(_ tripToAggregate : ToAggregate) {
        
        container.performBackgroundTask { context in
            
            log("store trip to aggregate")
            
        }
    }
    
    public func storeAlertToAggregate(_ alert : ToAggregate) {
        
        container.performBackgroundTask { context in
            
            log("store alert to aggregate")
        }
    }
    
    public func storeAlert(_ alert : AlertInfo) {
        
        container.performBackgroundTask { context in
            
            log("store alert")
        }
    }
    
    public func loadUser(_ sampleUser : SampleUser) {
        container.performBackgroundTask { context in
            
            log("load user")
            
            let fetchUser : NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
            fetchUser.predicate = NSPredicate(format : self.id + self.equals_int,
                                              nextAPI.toInt(sampleoUser.getId()))
            
            let userResult : [UserInfo] = self.pull(context, fetchUser)
            
            if(userResult.count == 1) {
                
                log("found user with username " + (userResult.first?.username ?? "nil"))
                
                sampleUser.updateFromDatabase(userResult.first?.username ?? self.empty,
                                            userResult.first?.first_name ?? self.empty,
                                            userResult.first?.last_name ?? self.empty,
                                            userResult.first?.email ?? self.empty,
                                            userResult.first?.phone ?? self.empty,
                                            nextAPI.toU32(userResult.first?.id ??
                                                          0),
                                            nextAPI.toU32(userResult.first?.image_id ??
                                                          0),
                                            nextAPI.toU32(userResult.first?.terms_id ??
                                                          0)
                                            )
            }
            else {
                log("did not find user")
            }
            
            context.reset()
        }
    }
    
    public func loadUserAccount(_ sampleUserAccount : SampleUserAccount,
                                _ deviceManager : SampleDeviceManager,
                                _ userAccountsManager : UserAccountsManager) {

        container.performBackgroundTask { context in
            
            log("load user account")
            
            let fetchToken = AuthToken.fetchRequest()
            
            let tokenResult : [AuthToken] = self.pull(context, fetchToken)
            
            if(tokenResult.count == 1) {
                
                log("found a token with user id " + String(tokenResult.first?.user_id ?? 0))
                
                let fetchUser = UserInfo.fetchRequest()
                
                let predicate = NSPredicate(format : self.id + self.equals_int,
                                            tokenResult.first?.user_id ?? 0)
                fetchUser.predicate = predicate
                
                log("predicate format " + predicate.predicateFormat)
                
                let userResult : [UserInfo] = self.pull(context, fetchUser)
                
                if(userResult.count == 1) {
                
                    log("found a user")

                    
                    
                    sampleUserAccount.updateFromDatabase(
                        userResult.first?.username ?? self.empty,
                        userResult.first?.first_name ?? self.empty,
                        userResult.first?.last_name ?? self.empty,
                        userResult.first?.email ?? self.empty,
                        userResult.first?.phone ?? self.empty,
                        nextAPI.toU32(userResult.first?.id ?? 0),
                        nextAPI.toU32(userResult.first?.image_id ?? 0),
                        nextAPI.toU32(userResult.first?.terms_id ?? 0))
                    
                    sampleUserAccount.updateAuthFromDatabase(
                        Array(tokenResult.first?.auth_token ?? Data()),
                        Array(tokenResult.first?.apple_id ?? Data()))
                
                    
                    
                    log("load user settings")
                    
                    // 10/06/2022: fetch the user's settings
                    
                    let fetchSettings : NSFetchRequest<UserSetting> = UserSetting.fetchRequest()
                    fetchSettings.predicate = NSPredicate(
                        format : self.user_id + self.equals_int,
                        nextAPI.toInt(sampleUserAccount.getId()))
                    
                    let settingResult : [UserSetting] = self.pull(
                        context, fetchSettings)
                    
                    if(settingResult.count == 1) {
                        
                        log("found the user setting")
                        
                        sampleUserAccount.getLinkedSettingsMonitor()
                            .updateFromDatabase(
                                settingResult.first?.auto_key ?? false,
                                settingResult.first?.threshold_notif ?? false,
                                settingResult.first?.traffic_notif ?? false,
                                settingResult.first?.all_notif ?? false,
                                settingResult.first?.email_notif ?? false,
                                settingResult.first?.text_notif ?? false,
                                settingResult.first?.inapp_notif ?? false,
                                settingResult.first?.accident_notif ?? false,
                                settingResult.first?.security_notif ?? false,
                                settingResult.first?.diagnostic_notif ?? false,
                                settingResult.first?.behavior_notif ?? false,
                                u16(settingResult.first?.overspeed ?? 0),
                                settingResult.first?.emergency_contacts ?? false,
                                UnitSystem(rawValue: nextAPI.toInt(settingResult.first?
                                    .unit_system ?? 0)) ?? .Metric,
                                PrivacySetting(rawValue: nextAPI.toInt(settingResult.first?
                                    .privacy ?? 0)) ?? .NO_STORING,
                                settingResult.first?.roadside ?? false,
                                settingResult.first?.safety_notif ?? false,
                                settingResult.first?.snapshot ?? false
                            )
                        
                        log("load linked devices")
                        
                        // 10/06/2022: fetch the user's linked devices
                        let fetchDevices : NSFetchRequest<DeviceUser> = DeviceUser.fetchRequest()
                        
                        fetchDevices.predicate = NSPredicate(format : self.user_id +
                                                             self.equals_int,
                                                             sampleUserAccount.getId())
                        
                        var devices : [u32 : SampleDevice] = [:]
                        var users : [u32 : SampleUser] = [:]
                        
                        let devicesResult : [DeviceUser] = self.pull(context, fetchDevices)
                        
                        for deviceResult in devicesResult {
                            
                            let dev : SampleDevice = deviceManager
                                .getDevice(nextAPI.toU32(deviceResult.obd_serial))
                            
                            // 11/02/2022: load device info
                            self.loadDeviceInfo(dev)
                            
                            // 11/02/2022: remember the linked device
                            // when notifying the linked devices callbacks
                            devices[nextAPI.toU32(deviceResult.obd_serial)] = dev
                            
                            // 11/02/2022: get the linked users
                            
                            let fetchUsers : NSFetchRequest<DeviceUser> = DeviceUser.fetchRequest()
                            
                            fetchUsers.predicate = NSPredicate(format : self.obd_serial + self.equals_int, deviceResult.obd_serial)
                            
                            let usersResult : [DeviceUser] = self.pull(context, fetchUsers)
                            
                            for userResult in usersResult {
                                
                                let user : SampleUser = userAccountsManager.getUser(
                                    nextAPI.toU32(userResult.user_id))
                                
                                // 11/02/2022: load user info
                                self.loadUser(user)
                                
                                // 11/02/2022: remember the linked user
                                // when notifying the linked users callback
                                users[nextAPI.toU32(userResult.user_id)] = user
                                
                                dev.getUserControls().addUser(user, Permission(rawValue : nextAPI.toInt(userResult.permission)) ?? .DENIED)
                            }
                            
                        } // 11/02/2022: end for each linked device
                        

                        // 11/02/2022: notify the linked user and device callbacks
                        
                        var devArr : [SampleDevice] = []
                        var userArr : [SampleUser] = []

                        devArr.append(contentsOf : devices.values)
                        userArr.append(contentsOf : users.values)
                        
                        sampleUserAccount.getLinkedDeviceMonitor().notifyCallbacks(devArr, sampleUserAccount)
                        sampleUserAccount.getLinkedUserMonitor().notifyCallbacks(userArr, sampleUserAccount)

                    }
                    else {
                        log("did not find the user setting")
                    }
                    
                
                    
                    
                    // 10/06/2022: fetch the user's linked users
                    
                    // 10/06/2022: fetch the user's linked requests
                    
                    // 10/06/2022: fetch the user's emergency contacts
                }
                else {
                    log("did not find a user")
                }
                
            }
            else {
                log("did not find a token")
            }
            
            
            context.reset()
        }
    }
    
    public func loadHistoricalTime(_ historical : Historical) {
        
        container.performBackgroundTask { context in
            log("load historical times")
            
            
            let fetch : NSFetchRequest<HistoricalTime> = HistoricalTime.fetchRequest()
            fetch.predicate = NSPredicate(format : self.user_id + self.equals_int, nextAPI.toInt(SampleAPIImpl.getInstance().getUserAccountsManager().getSampleUserAccount().getId() ?? 0))
            
            let hist_times : [HistoricalTime] = self.pull(context,
                                                         fetch)
            
            for hist_time in hist_times {
                historical.onTimeLoaded(hist_time.id, hist_time.time)
            }
            
            
            // 09/14/2022: request more recent historical
            // data
            historical.resumeHistoricalLoading()
            
            
            context.reset()
        }
    }
    
    public func loadDeviceInfo(_ sampleDevice : SampleDevice) {
        
        container.performBackgroundTask { context in
            log("load device info")
            
            let fetchDevice : NSFetchRequest<DeviceInfo> = DeviceInfo.fetchRequest()
            
            fetchDevice.predicate = NSPredicate(format : self.obd_serial + self.equals_int,
                                                nextAPI.toInt(sampleDevice.getId()))
            
            let deviceResult : [DeviceInfo] = self.pull(context, fetchDevice)
            
            if(deviceResult.count == 1) {
                log("found the device")
                
                sampleDevice.updateFromDatabase(Array(deviceResult.first?.enc_key ?? Data()),
                                              deviceResult.first?.devname ?? self.empty,
                                              deviceResult.first?.hardware_ver ?? self.empty,
                                              deviceResult.first?.firmware_ver ?? self.empty,
                                              deviceResult.first?.reg_key ?? self.empty,
                                              nextAPI.toU32(deviceResult.first?.image_id ?? 0)
                                              
                )
                
                // 11/28/2022: load device settings
                
                let fetchSettings : NSFetchRequest<DeviceSetting> = DeviceSetting.fetchRequest()
                
                fetchSettings.predicate = NSPredicate(format : self.obd_serial + self.equals_int,
                                                      nextAPI.toInt(sampleDevice.getId()))
                
                let settingResults : [DeviceSetting] = self.pull(context, fetchSettings)
                
                if(settingResults.count == 1) {
                    log("found device settings")
                    
                    sampleDevice.getSettingControls().updateFromDatabase(
                        settingResults.first?.auto_key ?? false,
                        settingResults.first?.lock_unlock ?? false,
                        settingResults.first?.immobilize ?? false,
                        settingResults.first?.sched_immobilize ?? false,
                        settingResults.first?.stop_park ?? false,
                        settingResults.first?.start_stop ?? false,
                        settingResults.first?.key_driver_door ?? false,
                        settingResults.first?.auto_stop ?? false,
                        nextAPI.toU8(settingResults.first?.auto_stop_time ?? 0),
                        PrivacySetting(rawValue : nextAPI.toInt(settingResults.first?.privacy ?? 0)) ??
                            .NO_SENDING,
                        settingResults.first?.proximity_mobilize ?? false
                    )
                }
                else {
                    log("failed to find device settings")
                }
                
            }
            else {
                log("did not find the device")
            }
            
            
            context.reset()
            
        }
    }
    
    public func loadImage(_ imageID: u32, _ identifier : BasicIdentifier) {
        
        container.performBackgroundTask { context in
            
            log("load image")
            
            let fetchImage : NSFetchRequest<SampleImage> = SampleImage.fetchRequest()
            
            fetchImage.predicate = NSPredicate(format : self.id + self.equals_int,
                                               nextAPI.toInt(imageID))
            
            let imageResult : [SampleImage] = self.pull(context, fetchImage)
            
            if(imageResult.count == 1) {
                
                log("found an image")
                identifier.updateImage(
                    imageID, Array(imageResult.first?.image ?? Data()))
                
            }
            else {
                log("failed to find image")
                
                identifier.requestAvatar()
            }
            
            
            context.reset()
            
        }
    }
    
    public func loadClientPermissions(_ clientPermissions : ClientPermissions) {
        
        container.performBackgroundTask { context in
            
            log("load client permissions")
            
            let fetchRequest : NSFetchRequest<ClientPermission> = ClientPermission.fetchRequest()
            
            let permResults : [ClientPermission] = self.pull(context, fetchRequest)
            
            if(permResults.count == 1) {
                log("found client permissions")
                
                clientPermissions.updateFromDatabase(
                    Array(permResults.first?.permission ?? Data()))
            }
            else {
                log("did not find client permissions")
            }
            
            
            context.reset()
        }
    }
    
    public func loadTrip(_ trip : TripInformation) {
        
        container.performBackgroundTask { context in
            
            log("load trip information")
            
            let fetch : NSFetchRequest<TripInfo> = TripInfo.fetchRequest()
            fetch.predicate = NSPredicate(format : self.id + self.equals_int,
                                          nextAPI.toInt(trip.getId()))
            
            let tripResults : [TripInfo] = self.pull(context, fetch)
            
            if(tripResults.count == 1) {
                log("found a trip")
                
                trip.updateFromDatabase(nextAPI.toU32(tripResults.first?.obd_serial ?? 0),
                                        nextAPI.toU16(tripResults.first?.points_total ?? 0),
                                        tripResults.first?.valid_gps ?? false,
                                        tripResults.first?.start_stop ?? false,
                                        nextAPI.toU32(tripResults.first?.user_id ?? 0))
                
                (trip as DrivingRecord).updateFromDatabase(
                    nextAPI.toU32(tripResults.first?.id ?? 0),
                    nextAPI.toU32(tripResults.first?.duration ?? 0),
                    Double(tripResults.first?.distance ?? 0),
                    Double(tripResults.first?.fuel_used ?? 0),
                    Double(tripResults.first?.economy ?? 0),
                    nextAPI.toU32(tripResults.first?.stop_time ?? 0),
                    nextAPI.toU32(tripResults.first?.idle_time ?? 0),
                    Double(tripResults.first?.fuel_saved ?? 0),
                    Double(tripResults.first?.co2_saved ?? 0),
                    nextAPI.toU64(tripResults.first?.start_time ?? 0),
                    nextAPI.toU64(tripResults.first?.end_time ?? 0),
                    nextAPI.toU32(tripResults.first?.alert_count ?? 0)
                )
            }
            else {
                log("did not find a trip")
            }
            
            
            context.reset()
            
        }
    }
    
    public func loadPointsByTrip(_ trip : TripInformation) {
        
        container.performBackgroundTask { context in
            
            log("load points by trip")
            
            let fetch : NSFetchRequest<TripPoint> = TripPoint.fetchRequest()
            fetch.predicate = NSPredicate(format : self.trip_id + self.equals_int,
                                          nextAPI.toInt(trip.getId()))
            
            let pointResults : [TripPoint] = self.pull(context, fetch)
            
            if(pointResults.count == 0) {
                trip.requestPointsFromServer()
            }
            else {
                for pointResult in pointResults {
                    
                    let coor : LocationCoordinate = LocationCoordinateImpl(
                        pointResult.latitude, pointResult.longitude,
                        nextAPI.toU64(pointResult.gps_time),
                        nextAPI.toU32(pointResult.index),
                        nextAPI.toU16(pointResult.heading),
                        nextAPI.toU32(pointResult.trip_id))
                    
                    trip.addToPath(coor)
                }
            }
            
            context.reset()
        }
    }
    
    public func loadLastPointForTrip(_ last_index : Int, _ trip : TripInformation) {
        
        container.performBackgroundTask { context in
            
            log("load last point for trip")
            
        }
    }
    
    public func loadAggregate(_ aggregate : DrivingAggregate) {
        
        container.performBackgroundTask { context in
            
            log("load aggregate")
            
            let fetch : NSFetchRequest<Aggregate> = Aggregate.fetchRequest()
            let creator_predicate = NSPredicate(
                format : self.creator_id + self.equals_int,
                nextAPI.toInt(aggregate.getSearchCriteria().getCreatorID()))
            let viewer_predicate = NSPredicate(
                format : self.user_id + self.equals_int,
                nextAPI.toInt(aggregate.getSearchCriteria().getViewerID()))
            let bottom_predicate = NSPredicate(
                format : self.start_time + self.equals_int,
                nextAPI.toS64(aggregate.getSearchCriteria().getBottomTime()))
            let type_predicate = NSPredicate(
                format : self.agg_type + self.equals_int,
                nextAPI.toS16(aggregate.getSearchCriteria().getType().rawValue))
                
            fetch.predicate = NSCompoundPredicate(andPredicateWithSubpredicates : [creator_predicate, viewer_predicate, bottom_predicate, type_predicate])
            
            let aggResults : [Aggregate] = self.pull(context, fetch)
            
            if(aggResults.count == 1) {
                log("found the aggregate")

                aggregate.updateFromDatabase(
                    nextAPI.toU32(aggResults.first?.id ?? 0),
                    nextAPI.toU32(aggResults.first?.duration),
                    aggResults.first?.distance ?? 0,
                    aggResults.first?.fuel_used ?? 0,
                    aggResults.first?.economy ?? 0,
                    nextAPI.toU32(aggResults.first?.stop_time ?? 0),
                    nextAPI.toU32(aggResults.first?.idle_time ?? 0),
                    aggResults.first?.fuel_saved ?? 0,
                    aggResults.first?.co2_saved ?? 0,
                    nextAPI.toU64(aggResults.first?.start_time ?? 0),
                    nextAPI.toU64(aggResults.first?.end_time ?? 0),
                    nextAPI.toU32(aggResults.first?.alert_count ?? 0))
            }
            else {
                log("failed to find the aggregate")
            }
            
            
            context.reset()
        }
        
    }
    
    public func loadTripIDsForAggregate(_ aggregate : DrivingAggregate) {
        
        container.performBackgroundTask { context in
            
            log("load trip ids for aggregate")
            
        }
    }
    
    public func loadTripsForAggregate(_ aggregate : DrivingAggregate) {
        
        container.performBackgroundTask { context in
            
            log("load trips by id")
            
        }
    }
    
    public func loadAlertsForAggregate(_ aggregate : DrivingAggregate) {
        
        container.performBackgroundTask { context in
            
            log("load alerts for aggregate")
        }
    }
    
    public func loadAlertsForTrip(_ trip : TripInformation) {
        
        container.performBackgroundTask { context in
            
            log("load alerts for trip")
        }
    }
    
    public func loadAlert(_ alert : AlertInfo) {
        
        container.performBackgroundTask { context in
            
            log("load alert")
        }
    }
        
    public func deleteAuth() {
        
        
        container.performBackgroundTask{ context in
            
            log("delete auth")
            
            let fetch : NSFetchRequest<AuthToken> = AuthToken.fetchRequest()
            
            
            let delete = NSBatchDeleteRequest(fetchRequest :
                                                fetch as! NSFetchRequest<NSFetchRequestResult>)
            
            if(!self.push(context, delete)) {
                log("delete auth failed")
            }
            
        }
    }
    
    private func push(_ context : NSManagedObjectContext,
                        _ writeRequest : NSPersistentStoreRequest) -> Bool {
        
        do {
            
            try context.execute(writeRequest)
            
            try context.save()
            
            log("save successful")
            
            context.reset()
            
            return true

        }
        catch {
            log("push error: " + error.localizedDescription)
            
            context.reset()
            
            return false
        }
    }
    
    private func pull<T>(_ context : NSManagedObjectContext,
                               _ fetchRequest : NSFetchRequest<T>) -> [T] {
        
        var ret : [T] = []
        do {
            ret = try context.fetch(fetchRequest)
            log("fetch successful, count " + String(ret.count))
            
            //context.reset()
        }
        catch {
            log("pull error: " + error.localizedDescription)
            
            //context.reset()
        }
        return ret
        
    }
    
    private func loadHandler(_ desc : NSPersistentStoreDescription, _ err : Error?) {
        
        log("load handler desc " + desc.debugDescription)
    }

}
