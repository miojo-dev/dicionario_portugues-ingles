program pointer_list;

uses crt;

type
    TInfo = string;
    TNode = ^TElement;
    TElement = record
        data : TInfo;
        next : TNode;
    end;

var option : byte;
    str : TInfo;
    str_list : TNode;

procedure ReadInfo(var info : TInfo);
begin
    clrscr;
    write('Insert the info: ');
    read(info);
end;

procedure CreateList(var list : TNode);
begin
    list := nil;
end;

procedure Include(var list : TNode; info : TInfo);
var aux, anterior, atual : TNode;
begin
    new(aux);
    if aux = nil then
    begin
        write('Memory full!'); readkey;
    end
    else
    begin
        aux^.data := info;
        aux^.next := nil;
        
        if (list = nil) or (info < list^.data) then
        begin
            aux^.next := list;
            list := aux;
        end
        else
        begin
            anterior := list;
            atual := list^.next;
            
            while (atual <> nil) and (info > atual^.data) do
            begin
                anterior := atual;
                atual := atual^.next;
            end;
            
            aux^.next := atual;
            anterior^.next := aux;
        end;
    end;
end;

procedure Remove(var list : TNode; info : TInfo);
var anterior, atual : TNode;
begin
    if list = nil then
    begin
        write('List is empty!'); readkey;
    end
    else
    begin
        anterior := nil;
        atual := list;
        
        while (atual <> nil) and (atual^.data <> info) do
        begin
            anterior := atual;
            atual := atual^.next;
        end;
        
        if atual = nil then
        begin
            write('Element not found!'); readkey;
        end
        else
        begin
            // Era o primeiro da lista?
            if anterior = nil then
                list := atual^.next
            else
                anterior^.next := atual^.next;
            
            writeln('Element ', atual^.data, ' removed!');
            dispose(atual);
            readkey;
        end;
    end;
end;

function CountElements(var list : TNode) : byte;
var aux : TNode;
    i : byte;
begin
    i := 0;
    
    if list <> nil then
    begin
        aux := list;
        
        while aux <> nil do
        begin
            i := i + 1;
            writeln(i, ' - ', aux^.data);
            aux := aux^.next;
        end
    end;
    
    CountElements := i;
end;

begin
    option := 1;
    CreateList(str_list);
    
    while option <> 0 do
    begin
        clrscr;
        writeln ('0 - Exit');
        writeln ('1 - Include');
        writeln ('2 - Remove');
        writeln ('3 - Count elements');
        readln (option);
        writeln;
       
        case option of
            1:
            begin
                ReadInfo(str);
                Include(str_list, str);
            end;
            
            2:
            begin
                ReadInfo(str);
                Remove(str_list, str);
            end;
            
            3:
            begin
                writeln(CountElements(str_list), ' elements');
                readkey;
            end;
        end;
    end;
end.
