codeunit 50135 "Dynamic Workflow"
{
    procedure CheckEmployeeApprovalsWorkflowEnabled(var RecRef: RecordRef): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(RecRef, GetWorkflowCode(RunWorkflowOnSendEmployeeForApprovalCode, RecRef)) then begin
            //   if WorkflowManagement.EnabledWorkflowExist(DATABASE::Employee,  WorkflowEventHandling().RunWorkflowOnVendorChangedCode()) then
            //   exit(false);
            // end;
            Error(NoWorkflowEnabledErr);
        end;
        exit(true);
    end;

    local procedure GetWorkflowCode(WorkflowCode: Code[128]; RecRef: RecordRef): Code[128];

    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name, '=', '')));
    end;


    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeForApproval(var RecRef: RecordRef)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeForApproval(var RecRef: RecordRef)
    begin
    end;
    //Add event to library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::Employee);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOnSendEmployeeForApprovalCode, RecRef), DATABASE::Employee,
          GetWorkflowEventDesc(EmployeeSendForApprovalEventDescTxt, RecRef), 0, false);
        WorkflowEventHandling.AddEventToLibrary(GetWorkflowCode(RunWorkflowOnCancelEmployeeForApprovalCode, RecRef), DATABASE::Employee,
          GetWorkflowEventDesc(EmployeeCancelForApprovalEventDescTxt, RecRef), 0, false);
    end;

    //subscribe
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dynamic Workflow", OnSendEmployeeForApproval, '', false, false)]
    local procedure RunWorkflowOnSendEmployeeForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowOnSendEmployeeForApprovalCode, RecRef), RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dynamic Workflow", OnCancelEmployeeForApproval, '', false, false)]
    local procedure RunWorkflowOnCancelEmployeeForApproval(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowOnCancelEmployeeForApprovalCode, RecRef), RecRef);
    end;

    local procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text;

    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;

    //handle the document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Employee: Record Employee;
    begin
        case RecRef.Number of
            Database::Employee:
                begin
                    RecRef.SetTable(Employee);
                    Employee.Validate("View Status", Employee."View Status"::Open);
                    Employee.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Employee: Record Employee;
    begin
        case RecRef.Number of
            Database::Employee:
                begin
                    RecRef.SetTable(Employee);
                    Employee.Validate("View Status", Employee."View Status"::Pending);
                    Employee.Modify(true);
                    Variant := Employee;
                    IsHandled := true;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance");
    var
        Employee: Record Employee;
    begin
        case RecRef.Number of
            Database::Employee:
                begin
                    RecRef.SetTable(Employee);
                    ApprovalEntryArgument."Document No." := Employee."No.";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Employee: Record Employee;
    begin
        case RecRef.Number of
            Database::Employee:
                begin
                    RecRef.SetTable(Employee);
                    Employee.Validate("View Status", Employee."View Status"::Approved);
                    Employee.Modify(true);
                    Handled := true;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        Employee: Record Employee;
    begin
        case ApprovalEntry."Table ID" of
            Database::Employee:
                begin
                    if Employee.Get(ApprovalEntry."Document No.") then begin
                        Employee.Validate("View Status", Employee."View Status"::Rejected);
                        Employee.Modify(true);
                    end;
                end;
        end;

    end;


    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        j: Codeunit "Approvals Mgmt.";
        h: Codeunit "Workflow Response Handling";

        RunWorkflowOnSendEmployeeForApprovalCode: Label 'RunWorkflowOnSendEmployee%1ForApproval';
        RunWorkflowOnCancelEmployeeForApprovalCode: Label 'RunWorkflowOnCancelEmployee%1ForApproval';
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        EmployeeSendForApprovalEventDescTxt: Label 'Approval of a Employee is requested.';
        EmployeeCancelForApprovalEventDescTxt: Label 'Approval of a Employee is cancelled.';

}
