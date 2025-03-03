page 50129 "Dynamic List"
{
    PageType = List;
    ApplicationArea = All;
    Editable = false;
    CardPageId = "Dynamic Card";
    UsageCategory = Lists;
    Caption = 'Dynamic List';
    SourceTable = Employee;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = BasicHR;
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(FullName; Rec.FullName())
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the full name of the employee.';
                    Visible = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                    Visible = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s initials.';
                    Visible = false;
                }
                field("Title Job"; Rec."Title Job")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the postal code.';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the country/region of the address.';
                    Visible = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("View Status"; Rec."View Status")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'View Status';
                    ToolTip = 'Specifies the View Status ';
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                    Visible = false;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Private Phone No.';
                    ToolTip = 'Specifies the employee''s private telephone number.';
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Private Email';
                    ToolTip = 'Specifies the employee''s private email address.';
                    Visible = false;
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                    Visible = false;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a resource number for the employee.';
                    Visible = false;
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies if a comment has been entered for this entry.';
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Employee), "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("A&bsences")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'A&bsences';
                Image = Absence;
                RunObject = Page "Employee Absences";
                RunPageLink = "Employee No." = field("No.");
                ToolTip = 'View absence information for the employee.';
            }
            action("Absence Registration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Absence Registration';
                Image = Absence;
                RunObject = Page "Absence Registration";
                ToolTip = 'Register absence for the employee.';
            }
            action("Ledger E&ntries")
            {
                ApplicationArea = BasicHR;
                Caption = 'Ledger E&ntries';
                Image = VendorLedger;
                RunObject = Page "Employee Ledger Entries";
                RunPageLink = "Employee No." = field("No.");
                RunPageView = sorting("Employee No.")
                              order(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
            action("&Picture")
            {
                ApplicationArea = BasicHR;
                Caption = '&Picture';
                Image = Picture;
                RunObject = Page "Employee Picture";
                RunPageLink = "No." = field("No.");
                ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
            }
            action("Co&mments")
            {
                ApplicationArea = Comments;
                Caption = 'Co&mments';
                Image = ViewComments;
                RunObject = Page "Human Resource Comment Sheet";
                RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                ToolTip = 'View or add comments for the record.';
            }


        }
        area(Processing)
        {
            group(Process)
            {
                Caption = 'Process';
                Image = Process;
                action("AnnualPayment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Annual Employee Payment';
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Specifies the annual employee payment';

                    trigger OnAction()
                    var
                        Employee: Record Employee;
                    begin
                        Employee.Reset();
                        Employee.SetRange("No.", Rec."No.");
                        if Employee.FindFirst() then
                            Report.Run(Report::"Annual Employees Payment", true, false, Employee);
                    end;
                }
            }

        }
    }
}