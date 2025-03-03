report 50148 "Annual Employees Payment"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Annual Employee Payment';
    //DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }

            trigger OnAfterGetRecord()
            var
                EmplyPaymentAmnt: Decimal;
                EmplyCharge: Decimal;
                EmplyTax: Decimal;
                EmplyOutPayment: Decimal;
            begin
                EmplyPaymentAmnt := 8000;
                EmplyCharge := EmplyPaymentAmnt * 0.16;
                EmplyTax := EmplyPaymentAmnt * 0.05;
                EmplyOutPayment := 1000;


                LineNo += 1;
                GenjornLine.Init();
                GenjornLine."Line No." := LineNo;
                GenjornLine."Journal Template Name" := UserSetup."Journal Template Name0";
                GenjornLine."Journal Batch Name" := UserSetup."Journal Batch Name0";
                GenjornLine."Posting Date" := Today;
                GenjornLine."Document No." := DocumentNo;
                GenjornLine."Document Date" := Today;
                GenjornLine."Account Type" := GenjornLine."Account Type"::Employee;
                GenjornLine.Validate("Account No.", Employee."No.");
                GenjornLine.Description := 'Annual Employee Payment Charge' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenjornLine.Validate(Amount, -(EmplyPaymentAmnt));
                GenjornLine."Currency Code" := '';
                GenjornLine."Bal. Account Type" := GenjornLine."Bal. Account Type"::"G/L Account";
                GenjornLine."Bal. Account No." := ExpenseGLAcc;
                GenjornLine.Insert();

                LineNo += 1;
                GenjornLine.Init();
                GenjornLine."Line No." := LineNo;
                GenjornLine."Journal Template Name" := UserSetup."Journal Template Name0";
                GenjornLine."Journal Batch Name" := UserSetup."Journal Batch Name0";
                GenjornLine."Posting Date" := Today;
                GenjornLine."Document No." := DocumentNo;
                GenjornLine."Document Date" := Today;
                GenjornLine."Account Type" := GenjornLine."Account Type"::Employee;
                GenjornLine.Validate("Account No.", Employee."No.");
                GenjornLine.Description := 'Annual Employee Payment Charge ' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenjornLine.Validate(Amount, (EmplyOutPayment + EmplyCharge + EmplyTax));
                GenjornLine."Currency Code" := '';
                GenjornLine."Bal. Account Type" := GenjornLine."Bal. Account Type"::"G/L Account";
                GenjornLine."Bal. Account No." := '';
                GenjornLine.Insert();

                LineNo += 1;
                GenjornLine.Init();
                GenjornLine."Line No." := LineNo;
                GenjornLine."Journal Template Name" := UserSetup."Journal Template Name0";
                GenjornLine."Journal Batch Name" := UserSetup."Journal Batch Name0";
                GenjornLine."Posting Date" := Today;
                GenjornLine."Document No." := DocumentNo;
                GenjornLine."Document Date" := Today;
                GenjornLine."Account Type" := GenjornLine."Account Type"::"G/L Account";
                GenjornLine.Validate("Account No.", PaymentGLAcc);
                GenjornLine.Description := 'OutStanding Payment ' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenjornLine.Validate(Amount, -(EmplyOutPayment));
                GenjornLine."Currency Code" := '';
                GenjornLine."Bal. Account Type" := GenjornLine."Bal. Account Type"::"G/L Account";
                GenjornLine."Bal. Account No." := '';
                GenjornLine.Insert();

                LineNo += 1;
                GenjornLine.Init();
                GenjornLine."Line No." := LineNo;
                GenjornLine."Journal Template Name" := UserSetup."Journal Template Name0";
                GenjornLine."Journal Batch Name" := UserSetup."Journal Batch Name0";
                GenjornLine."Posting Date" := Today;
                GenjornLine."Document No." := DocumentNo;
                GenjornLine."Document Date" := Today;
                GenjornLine."Account Type" := GenjornLine."Account Type"::"G/L Account";
                GenjornLine.Validate("Account No.", FeesIncomeGLAcc);
                GenjornLine.Description := 'Annual Employee Payment ' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenjornLine.Validate(Amount, -(EmplyCharge));
                GenjornLine."Currency Code" := '';
                GenjornLine."Bal. Account Type" := GenjornLine."Bal. Account Type"::"G/L Account";
                GenjornLine."Bal. Account No." := '';
                GenjornLine.Insert();

                LineNo += 1;
                GenjornLine.Init();
                GenjornLine."Line No." := LineNo;
                GenjornLine."Journal Template Name" := UserSetup."Journal Template Name0";
                GenjornLine."Journal Batch Name" := UserSetup."Journal Batch Name0";
                GenjornLine."Posting Date" := Today;
                GenjornLine."Document No." := DocumentNo;
                GenjornLine."Document Date" := Today;
                GenjornLine."Account Type" := GenjornLine."Account Type"::"G/L Account";
                GenjornLine.Validate("Account No.", TaxGLAcc);
                GenjornLine.Description := 'Annual Employee Payment ' + Format(Date2DMY(CalcDate('-1y', Today), 3));
                GenjornLine.Validate(Amount, -(EmplyTax));
                GenjornLine."Currency Code" := '';
                GenjornLine."Bal. Account Type" := GenjornLine."Bal. Account Type"::"G/L Account";
                GenjornLine."Bal. Account No." := '';
                GenjornLine.Insert();
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    field(ExpenseGLAcc; ExpenseGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Expense G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));

                    }
                    field(FeesIncomeGLAcc; FeesIncomeGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fees Income G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));

                    }
                    field(TaxGLAcc; TaxGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tax G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));

                    }
                    field(PaymentGLAcc; PaymentGLAcc)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment G/L Account';
                        TableRelation = "G/L Account" where("Direct Posting" = const(true));

                    }
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document No.';
                    }
                    field(PostDirctly; PostDirctly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Dirctly';
                    }

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if ExpenseGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Expense G/L Account'));
        if FeesIncomeGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Fees Income G/L Account'));
        if TaxGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Tax G/L Account'));
        if PaymentGLAcc = '' then Error(StrSubstNo(RequiredErr, 'Payment G/L Account'));
        if DocumentNo = '' then Error(StrSubstNo(RequiredErr, 'Document No'));
        UserSetup.Get(UserId);
        UserSetup.TestField("User ID");
        UserSetup.TestField("Journal Template Name0");
        UserSetup.TestField("Journal Batch Name0");

        GenjornLine.Reset();
        GenjornLine.SetRange("Journal Template Name", UserSetup."Journal Template Name0");
        GenjornLine.SetRange("Journal Batch Name", UserSetup."Journal Batch Name0");
        if GenjornLine.FindFirst() then
            GenjornLine.DeleteAll();

    end;

    trigger OnPostReport()
    begin
        GenjornLine.Reset();
        GenjornLine.SetRange("Journal Template Name", UserSetup."Journal Template Name0");
        GenjornLine.SetRange("Journal Batch Name", UserSetup."Journal Batch Name0");
        if GenjornLine.FindFirst() then begin
            if not PostDirctly then
                Page.Run(Page::"Payment Journal", GenjornLine)
            else
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenjornLine);
        end;
    end;
    /*  rendering
     {
         layout(LayoutName)
         {
             Type = Excel;
             LayoutFile = 'mySpreadsheet.xlsx';
         }
     } */

    var
        ExpenseGLAcc: Code[20];
        FeesIncomeGLAcc: Code[20];
        TaxGLAcc: Code[20];
        PaymentGLAcc: Code[20];
        DocumentNo: Code[20];
        GenjornLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PostDirctly: Boolean;
        UserSetup: Record "User Setup";
        RequiredErr: Label 'please enter the %1, field';
}