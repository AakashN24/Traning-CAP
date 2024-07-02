using {incident.mgmt.db as db} from '../db/schema';
//using {JMREUSABLE_SB as s4} from './external/JMREUSABLE_SB';

service IncidentService {

    @odata.draft.enabled
    entity Incidents as
        projection on db.Incidents {
            *
        }
        actions {
            function getCurrentStatus()    returns String;
            action   ChangeUrgencytoHigh() returns String;
        };

    // action CloseIncident();
    @cds.redirection.target
    entity Incidents1 as projection on db.Incidents;

    @readonly
    entity Customers as projection on db.Customers;
}

extend projection IncidentService.Customers with {
    firstName || ' ' || lastName as name : String
}

// extend service IncidentService with {

//     entity MaintNotification as projection on s4.MaintNotification;

//     entity MeasPoint as projection on s4.MeasPoint;
    
//     entity MeasPoint1 as projection on s4.MeasPoint {
//         MPoint,
//         Floc
//     };


//}
