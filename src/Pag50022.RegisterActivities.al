page 50096 "Register Activities"
{
    Caption = 'Register Activities';
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(From; FromDate)
                {
                    Caption = 'From';
                    ApplicationArea = All;
                }
                field(To; ToDate)
                {
                    Caption = 'To';
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Register Activities")
            {
                ToolTip = 'Register All type of warehouse activities';
                ApplicationArea = All;
                Image = Register;
                trigger OnAction()
                var
                    WarehouseActivityLine: Record "Warehouse Activity Line";
                    WhseActivityRegister: Codeunit "Whse.-Activity-Register";
                    FromDT: DateTime;
                    ToDT: DateTime;
                begin
                    Clear(WarehouseActivityLine);
                    FromDT := CreateDateTime(FromDate, 0T);
                    ToDT := CreateDateTime(ToDate, 115900T);
                    WarehouseActivityLine.SetRange(SystemCreatedAt, FromDT, ToDT);
                    if WarehouseActivityLine.FindSet() then
                        repeat
                            if WhseActivityRegister.Run(WarehouseActivityLine) then;
                        until WarehouseActivityLine.Next() = 0;
                end;
            }
        }
    }
    var
        FromDate: Date;
        ToDate: Date;
}
