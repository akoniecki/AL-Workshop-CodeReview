// TICKET001 - AK - Message changed - 01.02.1984

pageextension 50000 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    VAR
        Sleep: Integer;
    BEGIN
        Sleep(1000);

        //>> TICKET001 - AK
        //MESSAGE('Hello world');
        MESSAGE('Hello World!');
        // << TICKET001 - AK
    END;
}

