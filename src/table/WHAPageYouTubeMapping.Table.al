table 83257 "Page YouTube Mapping"
{
    Caption = 'Page YouTube Mapping';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Page ID"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Video ID"; Text[20])
        {
            DataClassification = SystemMetadata;
        }
        field(3; Description; Text[100])
        {
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Page ID")
        {
            Clustered = true;
        }
    }
}

table 83258 "Table YouTube Mapping"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Video ID"; Text[20])
        {
            DataClassification = SystemMetadata;
        }
        field(3; Description; Text[100])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Table ID")
        {
            Clustered = true;
        }
    }
}
