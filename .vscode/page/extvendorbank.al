pageextension 50128 "Employee Account" extends "Vendor Bank Account Card"
{
    layout
    {
        addfirst(General)
        {
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
                ToolTip = 'Enter the Employee No.';
            }
        }
    }

}