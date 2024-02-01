codeunit 50022 SubRegisterWhseActivityEvent
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Order Processing DI", 'OnAfterMovementDocCreated', '', false, false)]
    local procedure EventOnAfterMovementDocCreated(WarehouseActivityNo: Code[20])
    var
        WhseActivityLine: Record "Warehouse Activity Line";
        WhseActivityRegister: Codeunit "Whse.-Activity-Register";
    begin
        if not EazySetupDI.Get() then
            exit;
        if not EazySetupDI."Auto Register Movements" then
            exit;
        WhseActivityLine.SetRange("No.", WarehouseActivityNo);
        if WhseActivityLine.FindSet() then
            repeat
                WhseActivityRegister.Run(WhseActivityLine);
            until WhseActivityLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Event Subscriber", 'OnAfterPickDocCreated', '', false, false)]
    local procedure EventOnAfterPickDocCreated(var EazyWebOrderLog: Record "EAZY Web Order Log DI")
    var
        EazyWhseDocDI: Record "EAZY Whse. Document DI";
        WhseActivityLine: Record "Warehouse Activity Line";
        WhseActivityRegister: Codeunit "Whse.-Activity-Register";
    begin
        if not EazySetupDI.Get() then
            exit;
        if not EazySetupDI."Auto Register Picks" then
            exit;
        if EazyWebOrderLog."Warehouse Doc. Status" = EazyWebOrderLog."Warehouse Doc. Status"::"Pick Doc. Created" then begin
            Clear(EazyWhseDocDI);
            EazyWhseDocDI.SetRange("Web Order Log No.", EazyWebOrderLog."Entry No.");
            EazyWhseDocDI.SetRange("Activity Type", EazyWhseDocDI."Activity Type"::Pick);
            EazyWhseDocDI.SetRange(Status, EazyWhseDocDI.Status::Pending);
            if EazyWhseDocDI.FindFirst() then begin
                WhseActivityLine.SetRange("No.", EazyWhseDocDI."Activity No.");
                if WhseActivityLine.FindSet() then
                    repeat
                        WhseActivityRegister.Run(WhseActivityLine);
                    until WhseActivityLine.Next() = 0;
                EazyWebOrderLog.Validate("Warehouse Doc. Status", EazyWebOrderLog."Warehouse Doc. Status"::Picked);
                // EazyWhseDocDI.Validate(Status, EazyWhseDocDI.Status::Finished);
            end;
        end;
    end;



    // [EventSubscriber(ObjectType::Table, Database::"EAZY Whse. Document DI", 'OnAfterInsertEvent', '', false, false)]
    // local procedure EventOnAfterInsertPick(var Rec: Record "EAZY Whse. Document DI"; RunTrigger: Boolean)
    // var
    //     WhseActivityLine: Record "Warehouse Activity Line";
    //     WhseActivityRegister: Codeunit "Whse.-Activity-Register";
    // begin
    //     if (Rec."Activity Type" = Rec."Activity Type"::Pick) and (Rec.Status = Rec.Status::Pending) then begin
    //         WhseActivityLine.SetRange("No.", Rec."Activity No.");
    //         if WhseActivityLine.FindSet() then
    //             repeat
    //                 WhseActivityRegister.Run(WhseActivityLine);
    //             until WhseActivityLine.Next() = 0;
    //         Rec.Validate(Status, Rec.Status::Finished);
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"EAZY Web Order Log DI", 'OnAfterValidateEvent', 'Warehouse Doc. Status', false, false)]
    // local procedure EventOnAfterValidateWhseDocStatus(var Rec: Record "EAZY Web Order Log DI"; var xRec: Record "EAZY Web Order Log DI")
    // var
    //     EazyWhseDocDI: Record "EAZY Whse. Document DI";
    //     WhseActivityLine: Record "Warehouse Activity Line";
    //     WhseActivityRegister: Codeunit "Whse.-Activity-Register";
    // begin
    //     if Rec."Warehouse Doc. Status" = Rec."Warehouse Doc. Status"::"Pick Doc. Created" then begin
    //         Clear(EazyWhseDocDI);
    //         EazyWhseDocDI.SetRange("Web Order Log No.", Rec."Entry No.");
    //         EazyWhseDocDI.SetRange("Activity Type", EazyWhseDocDI."Activity Type"::Pick);
    //         EazyWhseDocDI.SetRange(Status, EazyWhseDocDI.Status::Pending);
    //         if EazyWhseDocDI.FindFirst() then begin
    //             WhseActivityLine.SetRange("No.", EazyWhseDocDI."Activity No.");
    //             if WhseActivityLine.FindSet() then
    //                 repeat
    //                     WhseActivityRegister.Run(WhseActivityLine);
    //                 until WhseActivityLine.Next() = 0;
    //             EazyWhseDocDI.Validate(Status, EazyWhseDocDI.Status::Finished);
    //         end;
    //     end;
    // end;
    var
        EazySetupDI: Record "EAZY Setup DI";
}
