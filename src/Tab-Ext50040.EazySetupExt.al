tableextension 50080 "Eazy Setup Ext" extends "EAZY Setup DI"
{
    fields
    {
        field(50000; "Auto Register Picks"; Boolean)
        {
            Caption = 'Auto Register Picks';
            DataClassification = ToBeClassified;
        }
        field(50001; "Auto Register Movements"; Boolean)
        {
            Caption = 'Auto Register Movements';
            DataClassification = ToBeClassified;
        }
    }
}
