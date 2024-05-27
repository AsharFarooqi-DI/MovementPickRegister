pageextension 50085 "Eazy Setup Ext" extends "EAZY Setup DI"
{
    layout
    {
        addafter("Allow Large Order Qty. Sharing")
        {
            field("Auto Register Picks"; Rec."Auto Register Picks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto Register Picks field.';
            }
            field("Auto Register Movements"; Rec."Auto Register Movements")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Auto Register Movements field.';
            }
        }
    }
}
