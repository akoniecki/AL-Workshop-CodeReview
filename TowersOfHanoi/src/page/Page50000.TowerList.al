page 50000 TowersList
{
    PageType = List;
    SourceTable = TowerTable;
    SourceTableTemporary = true;
    ApplicationArea = All;
    Caption = 'Towers of Hanoi';
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Configuration)
            {
                Editable = true;
                field(NoOfDiscs; NoOfDiscs)
                {
                    Caption = 'No of Discs';
                    ToolTip = 'Put the number of disks';
                }
            }
            group(Solution)
            {
                repeater(Steps)
                {
                    field(Step; Rec.Step)
                    {
                        ToolTip = 'Step No.';
                    }
                    field(TowerA; Rec.TowerA)
                    {
                        ToolTip = 'Tower A';
                    }
                    field(TowerB; Rec.TowerB)
                    {
                        ToolTip = 'Tower B';
                    }
                    field(TowerC; Rec.TowerC)
                    {
                        ToolTip = 'Tower C';
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SolveIt)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Caption = 'Solve It!';
                ToolTip = 'Solve the tower';

                trigger OnAction();
                var
                    Solve: codeunit SolveTowersOfHanoi;
                begin
                    Solve.SolveTowersOfHanoi(Rec; NoOfDiscs; false)
                end;
            }
        }
    }

    var
        NoOfDiscs: Integer;

    trigger OnInit();
    begin
        NoOfDiscs := 5;
    end;
}
