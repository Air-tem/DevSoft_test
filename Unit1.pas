unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    RichEdit1: TRichEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TScount = record
    s:string;
    len:integer;
  end;
var
  Form1: TForm1;
  A1: set of char = [ '(' , '{' , '[' ];
  A2: set of char = [ ')' , '}' , ']' ];
  A3: set of char = [ '*' , '/' ];
  A4: set of char = [ '+' , '-' ];
  num: set of char = ['0'..'9' , '.' , ','];

function Calck(s:string; sq:char=' '):TScount;

implementation

{$R *.dfm}

function Calck(s:string; sq:char=' '):TScount;
var
  I,J,bufLen,leng,pos1: integer;
  oper1,oper2,sto:string;
  ans:real;
  res:TScount;
  op:char;
Begin
  res.s := '';
  res.len := 0;

	if sq=' ' then
		s := StringReplace(s , ' ','', [rfReplaceAll, rfIgnoreCase]);

  //второй параметр сохран€ет тип скобки котора€ открылась. эта проверка выставл€ет тип закрывающей скобки.
  //основна€ иде€ - между фигурн. скобк. и квадрат. в таблицe аски стоит по одному символу, поэтому просто к номеру вход. скобки
  //добавл€ем + 2, ну а между круглыми нет разрыва поэтому тут +1 и в итоге получаем закрывающюю скобку;
  if sq='(' then sq:=Char(ord(sq)+1) else sq:=Char(ord(sq)+2);

  //далее по приоритету операции - то что в скобках, потом умножен или деление, далее сложении вычитание.

   // избавл€емс€ от скобок. разбива€ выражение на более мелкие. +- стандартна€ зада€ о скобоч. выражени€х

  for I := 1 to s.Length do
    begin
    if s[i] in A1 then
      begin
        bufLen:=res.len;
        res := calck(copy(s,i+1),s[i]);
        Delete(s,i,res.len);
        res.len:=res.len+bufLen-res.s.Length;
        Insert(res.s,s,i);
      end;

   if s[i] in A2 then
    if s[i] = sq then
      begin
        Res.len:=res.len+i+1;
        s:=s.Remove(i-1);
        break;
      end else
           raise EConvertError.Create('Ќевалидное выражение, закрывающа€ скобка не соответствует открывающей');


    if i>=s.Length then break;
    end;

     //умножаем/делим
    i:=1;
    while (pos('*',s)>0)or(pos('/',s)>0) do
      begin
        if s[i] in A3 then
          begin
            j:=1;
            oper1:='';
            oper2:='';
            while (s[i-j] in num) do
              begin
                //oper1.Insert(1,s[i-j]);
                insert(s[i-j],oper1 ,1);
                pos1:=i-j;
                leng:=j;
                inc(j);
                if ((i-j)=0) then break;
              end;


             j:=1;
             if s[i+j]='-' then  inc(j);
             while (s[i+j] in num) do
              begin
                oper2:=oper2+s[i+j];
                inc(j);
                if (i+j)>s.Length  then  break;
              end;

              if s[i+1]='-' then insert('-',oper2,1);


            leng:=leng+j;

             if s[i]='*' then ans:=strtofloat(oper1)*strtofloat(oper2)
                else ans:=strtofloat(oper1)/strtofloat(oper2);

             Delete(s,pos1,leng);
             insert(floattostrf(ans,ffFixed,10,3),s,pos1);
             i:=pos1-1;

          end;

        if i>s.Length then break else inc(i);

      end;


      //складываем/вычетаем

    i:=1;

    while (pos('+',s)>0)or(pos('-',s)>0) do
      begin
        oper1:='';
        oper2:='';

        if s[1]='-' then
         begin
           inc(i);
           oper1:='-';
           if (pos('-',s)+pos('+',s))=1 then break;
         end;

        while not (s[i] in A4) do
          begin
            oper1:=oper1+s[i];
            inc(i);
          end;

        op:=s[i];
        inc(i);

        if s[i]='-' then
         begin
           inc(i);
           oper2:='-';
         end;

        while (not (s[i] in A4)) do
          begin
            oper2:=oper2+s[i];
            inc(i);
            if (i>s.Length) then break;
          end;


        if op='+' then ans:=strtofloat(oper1)+strtofloat(oper2)
                else ans:=strtofloat(oper1)-strtofloat(oper2);
             leng:=oper1.Length+oper2.Length+1;
             Delete(s,1,leng);
             insert(floattostr(ans),s,1);
              i:=1;
      end;


    res.s:=s; // }
    Result:=res;
End;

procedure TForm1.Button1Click(Sender: TObject);
const
  colors :array of TColor=[clAqua,clBlue,clFuchsia,clGray,clGreen,
                          clLime, clMaroon, clNavy, clOlive, clPurple,
                          clRed,clSilver,clTeal,clYellow];
var
  res:string;
  posis,i:integer;

begin
   try
    res:=calck(edit1.Text).s;
   except
     on EZeroDivide do
        begin
          showmessage('¬нутри выражени€ произошло деление на ноль!')  ;
        end;

     on E: EConvertError do
      begin
        showmessage( E.Message);

      end;
    end;
    posis:= pos(',',res);

    form1.RichEdit1.Text:=res;

    //возможно не совсем пон€л задачу подсветить. ну в целом каждый новый разр€д своим цветом. и так по кругу каждые 12 разр€дов.
    RichEdit1.SelStart  := pos(',',res);
    RichEdit1.SelLength := 3;
    RichEdit1.SelAttributes.Color := clred;
    dec(posis);
    i:=0;
    while posis>=0 do
    begin
        dec(posis);
        RichEdit1.SelStart  := i;
        RichEdit1.SelLength := 1;
        RichEdit1.SelAttributes.Color :=colors[i];
        inc(i);
        if i=12 then i:=0;
    end;
   {
    ;}
end;

end.
