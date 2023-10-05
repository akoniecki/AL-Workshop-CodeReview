codeunit 50000 SolveTowersOfHanoi
{
    var
        MaxSizeErr: Label 'Maximum Tower size is %1', Comment = '%1 = Number of disks';
        RecNotTemporaryErr: Label 'Internal error. Only temporary table is allowed.';

    procedure Solve(var TowerTableRec: record TowerTable; NoOfDiscs: Integer);
    begin
        // check if there is anything to process
        if NoOfDiscs > MaxStrLen(TowerTableRec.TowerA) then
            Error(MaxSizeErr, MaxStrLen(TowerTableRec.TowerA));

        if not TowerTableRec.IsTemporary() then
            Error(RecNotTemporaryErr);
        TowerTableRec.DeleteAll(true);

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
            source := CopyStr(source, 1, StrLen(source) - 1); // AK: warrning solved https://github.com/microsoft/AL/issues/1462#issuecomment-428944171

            r.Step := r.Step + 1;
            r.Insert();

            Move(r, n - 1, aux, target, source);
        end;
    end;
}