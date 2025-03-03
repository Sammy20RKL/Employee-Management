pageextension 50127 "User Setup Employee" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Journal Template Name0"; Rec."Journal Template Name0")
            {
                ApplicationArea = All;

            }
            field("Journal Batch Name0"; Rec."Journal Batch Name0")
            {
                ApplicationArea = All;
            }
            field("Journal Template Batch0"; Rec."Journal Template Batch0")
            {
                ApplicationArea = All;
                Visible = false;
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