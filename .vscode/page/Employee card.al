page 50130 "Dynamic Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Dynamic Card';
    SourceTable = Employee;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    //Visible = NoFieldVisible;
                    Importance = Standard;
                    ToolTip = 'Specify the employee No.';

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit()
                    end;

                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Enter the first name of the employee';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Enter the middle name of the employee';

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Enter the last name of the employee';

                }
                field("Title Job"; Rec."Title Job")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Job Title';
                    // Visible = false;

                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the Search Name';
                }
                field("View Status"; Rec."View Status")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the view status';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specify the Gender';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specify the phone number';

                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specify the last date modified';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specify the Company E-Mail';
                }
            }
            group("Address $ Contact")
            {
                group(Contro13)
                {
                    field(Address; Rec.Address)
                    {
                        Caption = 'Specify the Address';
                        ApplicationArea = BasicHR;
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Specifies the Address 2';

                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Specifies the City';
                    }
                }
                group(Control31)

                {
                    ShowCaption = false;
                    Visible = IsCountryVisible;
                    field(County; Rec.County)
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Specifies the county';
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Specifies the Post Code';
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Specifies the Country/Region Code';

                        trigger OnValidate()
                        begin
                            IsCountryVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
                        end;
                    }
                }
            }
            group(Admnistration)
            {
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = BasicHR;
                    Visible = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the employee became inactive due to disability or maternitry leave, for example.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code of the cause of inactivity code of the employee.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date whem the employee was terminated due to retirement or dismissal, for example.';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a termination code for employee who has been terminated.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies resopurce number for the employee.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies salesperson or purchase code for the employee.';
                }
            }
            group(Payments)
            {
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageId = "Employee Posting Groups";
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Employee),
                              "No." = field("No.");
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
            group("Employee")
            {
                Caption = 'Employee';
                Image = Employee;
                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ApplicationArea = Basic, Suite;
                    Enabled = Not OpenApprovalEntriesExist;
                    ToolTip = 'Send approval request to change the record. ';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        DynamicWorkflow: Codeunit "Dynamic Workflow";
                        RecRef: RecordRef;

                    begin
                        RecRef.GetTable(Rec);
                        if DynamicWorkflow.CheckEmployeeApprovalsWorkflowEnabled(RecRef) then
                            DynamicWorkflow.OnSendEmployeeForApproval(RecRef);

                    end;
                }

                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    ApplicationArea = Basic, Suite;
                    Enabled = NOT CanCancelApprovalForRecord;
                    ToolTip = 'Cancel the approval request';
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        DynamicWorkflow: Codeunit "Dynamic Workflow";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DynamicWorkflow.OnCancelEmployeeForApproval(RecRef);
                    end;
                }

                separator(action45)
                {

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
                action("A&bsences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'View absence information for the employee.';
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
        }

        /* area(Creation)
        {
            
        } */
        area(Processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;

                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View approval requests.';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }

                /*  {
                     Caption = 'Processing';
                     Image = Process; */
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

    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        HasApprovalEntries := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
    end;

    var
        NoFieldVisible, IsCountryVisible, OpenApprovalEntriesExist, CanCancelApprovalForRecord,
        OpenApprovalEntriesExistCurrUser, HasApprovalEntries : Boolean;

        FormatAddress: Codeunit "Format Address";

        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}