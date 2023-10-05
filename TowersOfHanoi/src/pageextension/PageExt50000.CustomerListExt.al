pageextension 50000 HelloWorldExt extends "Customer List"
{
    trigger OnOpenPage();
    begin
        MESSAGE('Hello World!');
    end;
}

