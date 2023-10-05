codeunit 50000 SolveTowersOfHanoi
{
    trigger OnRun()
    begin
    end;

    var
        Err: Label 'Maximum Tower size is %1';

    procedure Solve(var Rec: record TowerTable; NoOfDiscs: Integer);
    begin
        //check if there is anything to process
        if NoOfDiscs > MaxStrLen(Rec.TowerA) then begin
            Message(Err, MaxStrLen(Rec.TowerA));
        end
        else begin
            Rec.DeleteAll;
            Initialize(Rec, NoOfDiscs);
            Move(Rec, NoOfDiscs, Rec.TowerA, Rec.TowerC, Rec.TowerB);
        end;
    end;

    local procedure Initialize(var rec: record TowerTable; NoOFDiscs: Integer);
    var
        i: Integer;
    begin
        Rec.Step := 1;
        FOR i := NoOFDiscs DOWNTO 1 DO
            Rec.TowerA := Rec.TowerA + Format(i);
        Rec.INSERT();
        Commit();
    end;

    local procedure Move(var r: record TowerTable; n: integer; var source: Text[10]; var target: text[10]; var aux: text[10]);
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
}