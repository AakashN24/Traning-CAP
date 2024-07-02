using IncidentService as service from '../../srv/incident-service';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.SelectionFields            : [customer_ID],
    UI.FieldGroup #GeneratedGroup : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Customer',
                Value: customer_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Urgency',
                Value: urgencyCode,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Urgency code',
                Value: urgency_code,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Status',
                Value: status_code,
            },
        ],
    },
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Label: 'customer_ID',
            Value: customer_ID,
        }],
    },
    UI.FieldGroup #HeaderGroup1   : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Label: 'Created By',
            Value: createdBy,
        },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            }],
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Conversations',
            ID    : 'Conversations',
            Target: 'conversation/@UI.LineItem#Conversations',
        }
    ],
    UI.LineItem                   : [
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'IncidentService.ChangeUrgencytoHigh',
            Label : 'Change Urgency To High',
        },
        {
            $Type: 'UI.DataField',
            Value: title,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Customer',
            Value: customer_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Urgency',
            Value: urgencyCode,
        },
        {
            $Type      : 'UI.DataField',
            Label      : 'Status',
            Value      : status_code,
            Criticality: status.criticality,
        },
    ],
    UI.HeaderInfo                 : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Incident',
        TypeNamePlural: 'Incidents',
        Title         : {Value: 'Incident'}
    },
    UI.HeaderFacets               : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#HeaderGroup1',

    }]
);

annotate service.Incidents with {
    customer @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Customers',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: customer_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'firstName',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'lastName',
            },
        // {
        //     $Type : 'Common.ValueListParameterDisplayOnly',
        //     ValueListProperty : 'email',
        // },
        // {
        //     $Type : 'Common.ValueListParameterDisplayOnly',
        //     ValueListProperty : 'phone',
        // },
        ],
    }
};

annotate service.Incidents.conversation with @(UI.LineItem #Conversations: [
    {
        $Type: 'UI.DataField',
        Label: 'Author',
        Value: author,
    },
    {
        $Type: 'UI.DataField',
        Value: message,
        Label: 'Message',
    },
    {
        $Type: 'UI.DataField',
        Value: timestamp,
        Label: 'Date',
    },
]);