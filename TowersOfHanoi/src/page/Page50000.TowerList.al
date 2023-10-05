page 50000 TowersList
{
    PageType = List;
    SourceTable = 50000;
    SourceTableTemporary = true;
    Editable = true;
    ApplicationArea = All;
    Caption = 'Towers of Hanoi';
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Configuration)
            {
                field(NoOfDiscs; NoOfDiscs)
                {
                    Caption = 'No of Discs';
                }
            }
            group(Solution)
            {
                repeater(Steps)
                {
                    field(Step; Rec.Step)
                    {
                        Editable = false;
                    }
                    field(TowerA; Rec.TowerA)
                    {
                        Editable = false;
                    }
                    field(TowerB; Rec.TowerB)
                    {
                        Editable = false;
                    }
                    field(TowerC; Rec.TowerC)
                    {
                        Editable = false;
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
                PromotedCategory = New;

                trigger OnAction();
                var
                    Solve: codeunit 50000;
                begin
                    Solve.Solve(Rec, NoOfDiscs);
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