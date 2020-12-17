unit RegisterUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TRegister }

  TRegister = class(TForm)
    DataSource1: TDataSource;
    Image1: TImage;
    img_confirm: TImage;
    Mobile: TEdit;
    Pass: TEdit;
    img_back: TImage;
    Label_Moblie: TLabel;
    Label_email: TLabel;
    Label_firm: TLabel;
    First_Name: TEdit;
    SQLQuery1: TSQLQuery;
    Last_Name: TEdit;
    Email: TEdit;
    Username: TEdit;
    Label_firstname: TLabel;
    Label_lastname: TLabel;
    Label_username: TLabel;
    Label_passwd: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure img_backClick(Sender: TObject);
    procedure img_confirmClick(Sender: TObject);
  private

  public

  end;

var
  Register: TRegister;

implementation
uses LoginUnit;

{$R *.lfm}

{ TRegister }

procedure TRegister.img_backClick(Sender: TObject);
begin
  Register.close;
  Login.show;
end;

procedure TRegister.img_confirmClick(Sender: TObject);
begin
  if Username.Text='' then ShowMessage('Please fill in the required fields');
  if First_Name.Text='' then ShowMessage('Please fill in the required fields');
  if Last_Name.Text='' then ShowMessage('Please fill in the required fields');
  if Email.Text='' then ShowMessage('Please fill in the required fields');
  if Pass.Text='' then ShowMessage('Please fill in the required fields');
  if Mobile.Text='' then ShowMessage('Please fill in the required fields')

  else
  begin

  if SQLQuery1.Active then SQLQuery1.Close;

   SQLQuery1.UsePrimaryKeyAsKey := False;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.AddText('insert into Employee (Username,First_Name,Last_Name,Email,Passwd,Mobile)');
   SQLQuery1.SQL.AddText('values ('''+Username.Text+''', '''+First_Name.Text+''', '''+Last_Name.Text+''','''+Email.Text+''','''+Pass.Text+''','''+Mobile.Text+''')');
   SQLQuery1.Close;

  if MessageDlg('Question?','Do you want to create a new account?',mtWarning,[mbOk, mbNo, mbCancel], 0) = mrOk then
     begin
         try
           SQlQuery1.ExecSQL;
           ShowMessage('Account created successfully');
         except
           ShowMessage(' There is a problem. ');
         end;
         ShowMessage('You can log in now');
         Login.Show;
         Register.Close;
     end
    else
       MessageDlg('Information!','Nothing is being inserted! Aborted! ',mtInformation,[mbOk], 0) ;

end;
end;

procedure TRegister.FormCreate(Sender: TObject);
begin
  SQLQuery1.UsePrimaryKeyAsKey := False;
  SQLQuery1.Open;
end;

end.

