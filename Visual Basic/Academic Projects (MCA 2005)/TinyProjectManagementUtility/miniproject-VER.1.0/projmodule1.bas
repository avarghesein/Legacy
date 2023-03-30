Attribute VB_Name = "projmodule1"


Option Explicit

'--------------Global Connection------------------'

Public db_type_oracle As Boolean

Type dbase
    cn As New ADODB.Connection
End Type

Public dn As dbase
    
'---------------------------------------------------'

Type project
    pwd As String
    pid As Long
    pnam As String
    pdesc As String
    pdur As Long
    pstart As Date
    pmanager As Long
End Type

Type tasks
    tid As Long
    pid As Long
    tnam As String
    tdesc As String
    tdur As Long
    t_estart As Date
    t_lstart As Date
    tmanager As Long
End Type


Public glob_proj As project
Public glob_task As tasks


Public Sub addtocombobox(comb As ComboBox, rs As Recordset, field As String)

On Error GoTo cancel

comb.clear
If rs.RecordCount <= 0 Then Exit Sub
rs.MoveFirst
While Not rs.EOF
    comb.AddItem (Trim(rs.Fields(field)))
    rs.MoveNext
Wend
Exit Sub
cancel:
    MsgBox Err.Description
    
End Sub

Public Sub togglecombos(combo1 As ComboBox, combo2 As ComboBox, clrflg As Boolean)

On Error GoTo cancel

If clrflg = True Then combo2.clear

If combo1.ListCount > 0 Then
    combo1.Enabled = True
    combo2.Enabled = False
Else
    combo1.Enabled = False
    combo2.Enabled = False
End If
Exit Sub
cancel:
    MsgBox Err.Description
    
End Sub


Public Function savenewadmin(name As String, pass As String, chnge_pass As Boolean) As Boolean
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open
savenewadmin = True
X.BeginTrans
Set Y = X.Execute("select * from admins where(name='" & name & "' and pass='" & pass & "')")
If Y.RecordCount > 0 Then
   MsgBox "ADMINISTRATOR ALREADY EXSIST", vbCritical, "CREATING ADMINISTRATOR FAILED"
    savenewadmin = False
    X.RollbackTrans
Else
   If chnge_pass = False Then
        X.Execute ("insert into admins (name,pass) values('" & name & "','" & pass & "')")
        If MsgBox("ARE YOU SURE TO SAVE?", vbYesNo, "CONFIRM") = vbYes Then
            X.CommitTrans
        Else
            X.RollbackTrans
            savenewadmin = False
        End If
   Else
        X.Execute ("update admins set pass='" & pass & "' where name='" & name & "'")
        X.CommitTrans
  End If
End If
   
Exit Function
cancel:
    MsgBox Err.Description
    If X.State = 1 Then
        X.RollbackTrans
    End If
End Function

'-------------------RESHEDULING THE PROJECTS------------------'

Public Sub create_tmp_tables(create As Boolean)
On Error GoTo cancel

Dim X As New Connection
Set X = dn.cn
If X.State = 0 Then X.Open

If create = True Then
    
    X.Execute "select * into tmp_projects from projects"
    X.Execute "select * into tmp_subtasks from subtasks"
    X.Execute "select * into tmp_predecessortasks  from predecessortasks"
    X.Execute "select * into tmp_successortasks from successortasks"
    X.Execute "select * into tmp_subtasksassignedto from subtasksassignedto"
    X.Execute "select * into tmp_projectsassignedto from projectsassignedto"
    X.Execute "select * into tmp_projectinprogress from projectinprogress"
Else
    X.Execute "drop table tmp_projectinprogress"
    X.Execute "drop table tmp_subtasksassignedto"
    X.Execute "drop table tmp_projectsassignedto"
    X.Execute "drop table tmp_successortasks"
    X.Execute "drop table tmp_predecessortasks"
    X.Execute "drop table tmp_subtasks"
    X.Execute "drop table tmp_projects"
End If

Exit Sub
cancel:
    MsgBox Err.Description
End Sub


Public Sub reshedule(pid As Long)
On Error GoTo cancel
Dim X As New Connection
Set X = dn.cn
If X.State = 0 Then X.Open
    
    X.Execute "delete from tmp_projectinprogress"
    X.Execute "delete from tmp_subtasksassignedto"
    X.Execute "delete from tmp_projectsassignedto"
    X.Execute "delete from tmp_successortasks"
    X.Execute "delete from tmp_predecessortasks"
    X.Execute "delete from tmp_subtasks"
   
X.Execute "insert into tmp_subtasks(taskid,projid,taskname,taskdesc,taskduration," _
          & "taskearly,tasklate,taskmanager) select taskid,projid,taskname,taskdesc,taskduration," _
          & "null,null,taskmanager  from subtasks where projid=" & pid & ""

X.Execute "insert into tmp_predecessortasks(taskid,projid,taskrelated) select taskid,projid,taskrelated from predecessortasks where projid=" & pid & ""
X.Execute "insert into tmp_successortasks(taskid,projid,taskrelated) select taskid,projid,taskrelated from successortasks where projid=" & pid & ""
X.Execute "insert into tmp_projectsassignedto(personid,projid,assigneddate,status) select personid,projid,assigneddate,status from projectsassignedto where(projid=" & pid & _
          " and status='I')"

X.Execute "insert into tmp_projectinprogress select * from projectinprogress where projid=" & pid & ""

Exit Sub
cancel:
    MsgBox Err.Description
End Sub


Public Sub re_earlylatestarts_settings(pid As Long)

On Error GoTo cancel
Dim I As Integer
Dim X As New Connection
Dim y1 As New Recordset
Dim y2 As New Recordset
Dim comb As ComboBox
Dim tmp_strng1 As String
Dim end_date1 As Date
Dim tmp_date1 As Date

Set X = dn.cn
If X.State = adStateClosed Then X.Open

Set comb = introduction.projnamecombo

tmp_strng1 = "select distinct(taskid)as tids from tmp_predecessortasks " _
             & "where(projid=" & pid & " and taskrelated is "
             
             
Set y1 = X.Execute(tmp_strng1 & "not null)")
Call addtocombobox(comb, y1, "tids")
y1.Close

X.Execute "update tmp_subtasks set taskearly='" _
  & Format$(Str(glob_proj.pstart), "dd-mmm-yyyy") & "' where(" _
  & "projid=" & pid & " and taskid in(" & tmp_strng1 & "null)))"
  


I = 0
While comb.ListCount > 0
    
   tmp_strng1 = "select distinct(taskrelated) from tmp_predecessortasks" _
               & " where(projid=" & pid & " and taskid=" & Val(comb.List(I)) & ")"
               
   Set y1 = X.Execute(tmp_strng1)
   Set y2 = X.Execute("select taskid from tmp_subtasks where(projid=" & pid & " and " _
            & "taskid in(" & tmp_strng1 & ") and taskearly is not null)")
              
    
    If y1.RecordCount <> y2.RecordCount Then
       I = I + 1
    Else
       y1.Close
       Set y1 = X.Execute("select taskearly as dates,taskduration as duration" _
              & " from tmp_subtasks where(projid=" & pid & " and taskid in(" & tmp_strng1 & "))")
              
       tmp_date1 = max_or_min_dateafteradd(y1, True, "dates", "duration")

       X.Execute ("update tmp_subtasks set taskearly='" _
         & Format$(Str(tmp_date1), "dd-mmm-yyyy") & "' where" _
         & "(projid=" & pid & " and taskid=" & Val(comb.List(I)) & ")")
         
       comb.RemoveItem (I)
    End If
    
    If I = comb.ListCount Then I = 0
    y1.Close
    y2.Close
Wend

Set y1 = X.Execute("select taskid as taskids,taskearly as early,taskduration as dur from " _
       & "tmp_subtasks where(projid=" & pid & " and taskid in(select distinct(taskid) from " _
       & "tmp_successortasks where(projid=" & pid & " and taskrelated is null)))")
       
       
end_date1 = max_or_min_dateafteradd(y1, True, "early", "dur")
glob_proj.pdur = Abs(DateDiff("d", end_date1, glob_proj.pstart))


X.Execute ("update tmp_projects set projduration=" & glob_proj.pdur & " where " _
           & "projid=" & pid & "")
           
y1.MoveFirst
While Not y1.EOF
  X.Execute ("update tmp_subtasks set tasklate='" & Format$(Str(DateAdd("d", -y1("dur"), end_date1)), "dd-mmm-yyyy") _
    & "' where (projid=" & pid & "and taskid=" & y1("taskids") & ")")
      
  y1.MoveNext
Wend

y1.Close
Set y1 = X.Execute("select taskid as tids,taskduration as dur from tmp_subtasks where" _
       & "(projid=" & pid & " and taskid in(select distinct(taskid) from " _
       & " tmp_successortasks where(projid=" & pid & "and taskrelated is not null)))")
       
       
Call addtocombobox_extended(comb, y1, "tids", "dur")
y1.Close
I = 0
While comb.ListCount > 0
   
   tmp_strng1 = "select distinct(taskrelated) from tmp_successortasks where(" _
         & "projid=" & pid & " and taskid=" & Val(comb.List(I)) & ")"
         
   Set y1 = X.Execute(tmp_strng1)
   Set y2 = X.Execute("select taskid from tmp_subtasks where(projid=" & pid & " and " _
          & "taskid in( " & tmp_strng1 & " )and tasklate is not null)")

   If y1.RecordCount <> y2.RecordCount Then
      I = I + 1
   Else
      y1.Close
      Set y1 = X.Execute("select tasklate as late from tmp_subtasks where" _
             & "(projid=" & pid & " and taskid in (" & tmp_strng1 & "))")
             
      tmp_date1 = max_or_min_date(y1, False, "late")
      
      X.Execute ("update tmp_subtasks set tasklate='" & Format$(DateAdd("d", -comb.ItemData(I), tmp_date1), "dd-mmm-yyyy") _
                & "' where(projid=" & pid & " and taskid=" & Val(comb.List(I)) & ")")
                
      comb.RemoveItem (I)
   End If
   
   If I = comb.ListCount Then I = 0
   
   y1.Close
   y2.Close
Wend


X.Execute "insert into tmp_subtasksassignedto(personid,projid,taskid,assigneddate,status)  " _
  & " select taskmanager,projid,taskid,taskearly,'I' from tmp_subtasks where projid=" & pid & ""


X.Execute "update tmp_subtasksassignedto set status='C' where(projid=" & pid & " and taskid in(" & _
          " select distinct(taskid) from projectinprogress where(projid=" & pid & " and enddate is not null)))"


MsgBox "YOUR PROJECT RE-SHEDULING COMPLETED" & vbCrLf & "PROJECT ID:" & Str(pid) & _
         vbCrLf & "EXPECTED DURATION OF PROJECT:" & Str(glob_proj.pdur) & " DAYS" & vbCrLf _
         & "PROJECT'S STARTING DATE:" & Format$(Str(glob_proj.pstart), "DD-MMM-YYYY") & vbCrLf _
         & "PROJECT'S EXPECTED ENDING DATE:" & Format$(Str(end_date1), "DD-MMM-YYYY"), vbOKOnly, "PROJECT SHEDULE COMPLETE"
         
comb.clear

Exit Sub

cancel:
    MsgBox Err.Description
    comb.clear
End Sub

Public Sub save_resheduled(pid As Long)
On Error GoTo cancel
Dim Y As New Recordset
Dim X As New Connection
Dim per_id As Long
Dim per_pass As String

Set X = dn.cn
If X.State = 0 Then X.Open
    X.Execute "insert into  tmp_subtasksassignedto select * from subtasksassignedto" & _
         " where(projid=" & pid & " and status='T')"
    X.Execute "delete from  subtasksassignedto where projid=" & pid & ""
    X.Execute "insert into tmp_projectsassignedto select * from projectsassignedto" & _
              " where(projid=" & pid & " and status='T')"
    X.Execute "delete from  projectsassignedto where projid=" & pid & ""
    X.Execute "delete from  successortasks  where projid=" & pid & ""
    X.Execute "delete from  predecessortasks where projid=" & pid & ""
    X.Execute "delete from  projectinprogress where projid=" & pid & ""
    
    Set Y = X.Execute("select projmanager,projpassword from passwordstore where projid=" & pid & "")
    Y.MoveFirst
    per_id = Y("projmanager")
    per_pass = Y("projpassword")
    X.Execute "delete from  passwordstore where projid=" & pid & ""
    
    X.Execute "delete from  subtasks where projid=" & pid & ""
    X.Execute "delete from  projects where projid=" & pid & ""
    
    X.Execute "insert into projects select * from tmp_projects where projid=" & pid & ""
    X.Execute "insert into projectsassignedto(personid,projid,assigneddate,status)" & _
          " select * from tmp_projectsassignedto where projid=" & pid & ""
    
    X.Execute "insert into subtasks select * from tmp_subtasks where projid=" & pid & ""
    X.Execute "insert into subtasksassignedto(personid,projid,taskid,assigneddate,status)" & _
        " select * from tmp_subtasksassignedto where projid=" & pid & ""
    
    X.Execute "insert into successortasks select * from tmp_successortasks where projid=" & pid & ""
    X.Execute "insert into predecessortasks select * from tmp_predecessortasks where projid=" & pid & ""

   If MsgBox("THE CHANGE IS GOING TO BE MADE PERMANENT" & vbCrLf & "ARE YOU SURE", vbYesNo, "CONFIRM") = vbYes Then
        X.Execute "insert into passwordstore(projid,projmanager,projpassword) values (" & pid & "," & per_id & ",'" & per_pass & "')"
        X.Execute "insert into projectinprogress select * from tmp_projectinprogress where projid=" & pid & ""
        X.CommitTrans
    Else
        X.RollbackTrans
    End If
Exit Sub

cancel:
    
    MsgBox Err.Description
    X.RollbackTrans
End Sub


Public Sub addtocombolist(comb As Control, rs As Recordset, f1 As String, f2 As String)
On Error GoTo cancel

comb.clear
If rs.RecordCount <= 0 Then Exit Sub
rs.MoveFirst
While Not rs.EOF
    comb.AddItem (Trim(rs.Fields(f1)))
    comb.ItemData(comb.NewIndex) = Val(rs.Fields(f2))
    rs.MoveNext
Wend
Exit Sub
cancel:
    MsgBox Err.Description
    
End Sub


Public Function findindexofcombolist(comb As Control, strg As String) As Long
Dim I As Integer

findindexofcombolist = -1
For I = 0 To comb.ListCount - 1
    If Trim(comb.List(I)) = Trim(strg) Then
        findindexofcombolist = I
        Exit Function
    End If
Next I
    
End Function

Public Function findindexofcombolist1(comb As Control, ByVal item As Long) As Long
Dim I As Integer

findindexofcombolist1 = -1
For I = 0 To comb.ListCount - 1
    If comb.ItemData(I) = item Then
        findindexofcombolist1 = I
        Exit Function
    End If
Next I
    
End Function


Public Sub check3combolist(A As Control, B As Control, C As Control)
Dim I As Integer

For I = 0 To A.ListCount - 1 Step 1
    If A.Selected(I) Then
      Call add_remove_from_list(A, B, C, A.ItemData(I))
    End If
Next I

End Sub

Public Sub add_remove_from_list(A As Control, B As Control, C As Control, ByVal item As Long)
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset
Dim j As Integer

Set X = dn.cn
If X.State = 0 Then X.Open

Set Y = X.Execute("select distinct(taskrelated) as related from tmp_predecessortasks" & _
   " where(projid=" & glob_proj.pid & " and taskid=" & item & " and taskrelated is not null)")

If Not Y.EOF And Not Y.BOF Then
    Y.MoveFirst
    While Not Y.EOF
        Call add_remove_from_list(A, B, C, Y("related"))
        Y.MoveNext
    Wend
End If

If findindexofcombolist1(C, item) <> -1 Then
        j = findindexofcombolist1(B, item)
        If j <> -1 Then
            B.RemoveItem (j)
        End If
End If
    

Exit Sub
cancel:
    MsgBox Err.Description
    
End Sub



'-------------Registry handling & Data Base Connecting-----------'


Public Function inregistry() As Boolean
Dim X As String
X = GetSetting("project_scheduler", "data_base", "exsist", "FALSE")
If X = "FALSE" Then
    inregistry = False
Else
    inregistry = True
End If
End Function

Public Sub add_to_registry()
      
      SaveSetting "project_scheduler", "data_base", "exsist", "TRUE"
      SaveSetting "project_scheduler", "data_base", "dprovider", registry.tprovide
      SaveSetting "project_scheduler", "data_base", "dsource", registry.tdat
      SaveSetting "project_scheduler", "data_base", "duser", registry.tuserid
      SaveSetting "project_scheduler", "data_base", "dpass", registry.tpass
End Sub

Public Sub del_registry()

If GetSetting("project_scheduler", "data_base", "exsist", "FALSE") = "TRUE" Then
      DeleteSetting "project_scheduler", "data_base", "exsist"
      DeleteSetting "project_scheduler", "data_base", "dprovider"
      DeleteSetting "project_scheduler", "data_base", "dsource"
      DeleteSetting "project_scheduler", "data_base", "duser"
      DeleteSetting "project_scheduler", "data_base", "dpass"
End If

End Sub

Public Sub create_main_tables_access()

On Error Resume Next
 
 dn.cn.Execute "create table projects(projid  long ,projname  char(30) ,projdesc  char(200) ,projduration  long ,projstartdate date,projmanager  long ,completed  char(1) ,deleted  char(1) ,primary key(projid))"

 dn.cn.Execute "create table subtasks(taskid  long ,projid  long ,taskname  char(30) ,taskdesc  char(200) ,taskduration  long ,taskearly date,tasklate date,taskmanager  long ,primary key(projid,taskid),foreign key(projid) references projects)"

 dn.cn.Execute "create table predecessortasks(taskid  long ,projid  long ,taskrelated  long ,foreign key(projid,taskid) references subtasks)"

 dn.cn.Execute "create table passwordstore(projid  long ,projmanager  long ,projpassword  char(50) ,primary key(projid),foreign key(projid) references projects)"

 dn.cn.Execute "create table projectinprogress(taskid  long ,projid  long ,startdate date,enddate date,primary key(projid,taskid),foreign key(projid,taskid) references subtasks)"

 dn.cn.Execute "create table successortasks(taskid  long ,projid  long ,taskrelated  long ,foreign key(projid,taskid) references subtasks)"

 dn.cn.Execute "create table person(name  char(50) ,address  char(200) ,age date,sex  char(1) ,id  long ,workingfor  char(200) ,fieldinterested  char(25) ,qualification  char(100),remarks  char(200) ,exsist  char(1) ,primary key(id))"

 dn.cn.Execute "create table admins(name  char(50) ,pass  char(50) ,primary key(name,pass))"

 dn.cn.Execute "create table subtasksassignedto(personid  long ,projid  long ,taskid  long ,assigneddate date,status  char(1) , foreign key(personid) references person,foreign key(projid,taskid) references subtasks)"

 dn.cn.Execute "create table projectsassignedto(personid  long ,projid  long ,assigneddate date,status  char(1) , foreign key(personid) references person,foreign key(projid) references projects)"

 dn.cn.Execute "create table register(personid  long ,projid  long ,taskid  long ,entrydate date,enteringtime date,leavingtime date,remarks  char(200) ,difficulties  char(200) , errors  char(200) ,foreign key(personid) references person)"

End Sub

Public Sub create_main_tables_oracle()

On Error Resume Next

dn.cn.Execute "create table projects(projid number(7),projname varchar2(30),projdesc  varchar2(200),projduration number(8),projstartdate date,projmanager   number(7),completed varchar2(1),deleted varchar2(1),primary key(projid))"


dn.cn.Execute "create table subtasks(taskid  number(7),projid  number(7),taskname varchar2(30),taskdesc varchar2(200),taskduration number(20),taskearly date,tasklate date,taskmanager number(7),primary key(projid,taskid),foreign key(projid) references projects)"


dn.cn.Execute "create table predecessortasks(taskid number(7),projid number(7) ,taskrelated number(7),foreign key(projid,taskid) references subtasks)"


dn.cn.Execute "table passwordstore(projid  number(7),projmanager  number(7),projpassword varchar2(50) ,primary key(projid),foreign key(projid) references projects)"


dn.cn.Execute "create table projectinprogress(taskid  number(7),projid  number(7),startdate date,enddate date,primary key(projid,taskid),foreign key(projid,taskid) references subtasks)"


dn.cn.Execute "create table successortasks(taskid  number(7),projid  number(7),taskrelated number(7),foreign key(projid,taskid) references subtasks)"

dn.cn.Execute "create table person(name varchar2(50),address varchar2(200),age date,sex varchar2(1),id number(7),workingfor varchar2(200),fieldinterested varchar2(25),qualification varchar2(100),remarks varchar2(200),exsist varchar2(1),primary key(id))"
 

dn.cn.Execute "create table  admins(name varchar2(50),pass  varchar2(50),primary key(name,pass))"


dn.cn.Execute "create table subtasksassignedto(personid number(7),projid number(7),taskid number(7),assigneddate date,status varchar2(1),foreign key(personid) references person,foreign key(projid,taskid) references subtasks)"


dn.cn.Execute "create table projectsassignedto(personid  number(7),projid  number(7),assigneddate  date,status varchar2(1),foreign key(personid) references person,foreign key(projid) references projects)"
 

dn.cn.Execute "create table register(personid number(7),projid number(7),taskid number(7),entrydate date,enteringtime date,leavingtime date,remarks varchar2(200),difficulties varchar2(200),errors varchar2(200),foreign key(personid) references person)"

End Sub



