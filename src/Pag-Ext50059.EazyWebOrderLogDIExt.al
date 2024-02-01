pageextension 50059 "Eazy Web Order Log DI Ext" extends "EAZY Web Order Log DI"
{
    actions
    {
        addafter(GetWebShopLineNo)
        {
            action("Register Activities")
            {
                ToolTip = 'Register All type of warehouse activities';
                ApplicationArea = All;
                Image = Register;
                trigger OnAction()
                var
                begin
                    Page.RunModal(Page::"Register Activities");
                end;
            }
        }
    }
}
