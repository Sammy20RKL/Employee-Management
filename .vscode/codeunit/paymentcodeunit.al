/*codeunit 50138 "Employee Payment Management"
{
    Caption = 'Employee Payment Management';

    procedure PayEmployee(EmployeeNo: Code[20]; PaymentAmount: Decimal)
    var
        Employee: Record Employee;
        PaymentEntry: Record "Employee Payment Entry";
        IsHandled: Boolean;
    begin
        if not Employee.Get(EmployeeNo) then
            Error('Employee %1 does not exist.', EmployeeNo);

        // Validate the payment amount
        if PaymentAmount <= 0 then
            Error('Payment amount must be greater than zero.');

        // Trigger event for custom validation
        OnBeforePayEmployee(Employee, PaymentAmount, IsHandled);
        if IsHandled then
            exit;

        // Post the payment
        PaymentEntry.Init();
        PaymentEntry."Employee No." := Employee."No.";
        PaymentEntry.Amount := PaymentAmount;
        PaymentEntry."Payment Date" := Today;
        PaymentEntry.Insert();

        OnAfterPayEmployee(Employee, PaymentAmount);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePayEmployee(var Employee: Record Employee; PaymentAmount: Decimal; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPayEmployee(var Employee: Record Employee; PaymentAmount: Decimal)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventToLibrary()
    var
        RecRef: RecordRef;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        RecRef.Open(Database::Employee);
        WorkflowEventHandling.AddEventToLibrary(
            GetWorkflowCode(RunWorkflowOnPayEmployeeCode, RecRef),
            DATABASE::Employee,
            GetWorkflowEventDesc(EmployeePaymentEventDescTxt, RecRef),
            0,
            false
        );
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dynamic Workflow", 'OnBeforePayEmployee', '', false, false)]
    local procedure RunWorkflowOnPayEmployee(var RecRef: RecordRef)
    begin
        WorkflowManagement.HandleEvent(GetWorkflowCode(RunWorkflowOnPayEmployeeCode, RecRef), RecRef);
    end;

    local procedure GetWorkflowCode(WorkflowCode: Code[128]; RecRef: RecordRef): Code[128]
    begin
        exit(DelChr(StrSubstNo(WorkflowCode, RecRef.Name), '=', ''));
    end;

    local procedure GetWorkflowEventDesc(WorkflowEventDesc: Text; RecRef: RecordRef): Text
    begin
        exit(StrSubstNo(WorkflowEventDesc, RecRef.Name));
    end;

    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";

        RunWorkflowOnPayEmployeeCode: Label 'RunWorkflowOnPayEmployee%1';
        EmployeePaymentEventDescTxt: Label 'Employee payment process started.';
}
*/