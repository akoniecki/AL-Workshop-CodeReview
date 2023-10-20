codeunit 50000 SolveTowersOfHanoi
{
    internal procedure SolveTowersOfHanoi(var TowerTableRec: Record TowerTable; var NoOfDiscs: Integer; var NoOfDiscs: Integer; HideDialog: Boolean)
    var
        IsHandled: Boolean;
    begin
        if not ConfirmSolveTowersOfHanoi(TowerTableRec, NoOfDiscs, HideDialog) then exit;
        OnBeforeSolveTowersOfHanoi(TowerTableRec, NoOfDiscs, IsHandled);
        DoSolveTowersOfHanoi(TowerTableRec, NoOfDiscs, IsHandled);
        OnAfterSolveTowersOfHanoi(TowerTableRec, NoOfDiscs,);
        AcknowledgeSolveTowersOfHanoi(TowerTableRec, NoOfDiscs, HideDialog)
    end;

    local procedure DoSolveTowersOfHanoi(var TowerTableRec: Record TowerTable; var NoOfDiscs: Integer; IsHandled: Boolean);
    begin
        if IsHandled then
            exit;

        if NoOfDiscs > MaxStrLen(TowerTableRec.TowerA) then
            Error(MaxSizeErr, MaxStrLen(TowerTableRec.TowerA));

        if not TowerTableRec.IsTemporary() then
            Error(RecNotTemporaryErr);
        TowerTableRec.DeleteAll(true);

        OnBeforeSolveTowersOfHanoi(TowerTableRec, NoOfDiscs, IsHandled);
        Initialize(TowerTableRec, NoOfDiscs);
        Move(TowerTableRec, NoOfDiscs, TowerTableRec.TowerA, TowerTableRec.TowerC, TowerTableRec.TowerB);
    end;

    local procedure Initialize(var rec: record TowerTable; NoOFDiscs: Integer);
    var
        i: Integer;
    begin
        Rec.Step := 1;
        FOR i := NoOFDiscs DOWNTO 1 DO
            Rec.TowerA := Rec.TowerA + Format(i);
        Rec.Insert();
    end;

    local procedure Move(var r: record TowerTable; n: integer; var source: Text[9]; var target: text[9]; var aux: text[9]);
    begin
        if n > 0 then begin
            Move(r, n - 1, source, aux, target);

            target := target + source[StrLen(source)];
            source := CopyStr(source, 1, StrLen(source) - 1);

            r.Step := r.Step + 1;
            r.Insert();

            Move(r, n - 1, aux, target, source);
        end;
    end;


    local procedure ConfirmSolveTowersOfHanoi(var TowerTableRec: Record TowerTable; var NoOfDiscs: Integer; HideDialog: Boolean): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        ConfirmQst: Label 'Are ready to solve Tower of Hanoi with %1 discs?', Comment 'No. of disks';
        DefaultAnswer: Boolean;
    begin
        DefaultAnswer := true;

        if HideDialog then exit(DefaultAnswer);
        exit(ConfirmManagement.GetResponseOrDefault(ConfirmQst, DefaultAnswer));
    end;

    local procedure AcknowledgeSolveTowersOfHanoi(var TowerTableRec: Record TowerTable; var NoOfDiscs: Integer; HideDialog: Boolean)
    var
        AcknowledgeMsg: Label 'You successfully solved the Towers of Hanoi.';
    begin
        if not GuiAllowed or HideDialog then exit;
        Message(AcknowledgeMsg);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSolveTowersOfHanoi(var TowerTableRec: Record TowerTable; var NoOfDiscs: Integer; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSolveTowersOfHanoi(var TowerTableRec: Record TowerTable; var NoOfDiscs: Integer);
    begin
    end;
}
