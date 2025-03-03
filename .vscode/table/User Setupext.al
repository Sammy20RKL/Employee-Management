tableextension 50115 "User Setup Employee" extends "User Setup"
{
    fields
    {
        field(50115; "Journal Template Name0"; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Template Name0';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50116; "Journal Batch Name0"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name0"));
        }
        field(50117; "Journal Template Batch0"; Code[21])
        {
            DataClassification = ToBeClassified;


        }
    }


}