tableextension 50135 post extends Employee
{
    DrillDownPageId = "Dynamic List";
    LookupPageId = "Dynamic List";


    fields
    {
        field(50124; "Title Job"; enum portal)
        {
            DataClassification = ToBeClassified;

        }

        field(50133; "View Status"; enum Accept)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }


}