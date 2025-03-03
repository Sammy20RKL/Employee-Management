pageextension 50126 Kisii extends "Employee Card"
{
    layout
    {
        addafter("Last Name")
        {
            field("Title Job"; Rec."Title Job")
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Name")
        {
            field("View Status"; Rec."View Status")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}